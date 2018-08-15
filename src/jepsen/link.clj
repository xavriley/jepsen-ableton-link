(ns jepsen.link
  (:require [clojure.tools.logging :refer :all]
            [clojure.string :as str]
            [clojure.java.shell :as shell]
            [jepsen [checker :as checker]
                    [cli :as cli]
                    [client :as client]
                    [control :as c]
                    [core :as core]
                    [db :as db]
                    [generator :as gen]
                    [nemesis :as nemesis]
                    [net :as net]
                    [tests :as tests]]
            [jepsen.checker.timeline :as timeline]
            [jepsen.control.net :as cn]
            [jepsen.control.util :as cu]
            [jepsen.os.debian :as debian]
            [knossos.model :as model]))

(declare cli-opts)

;; constants
(def logfile (str "/link.log"))

(defn db
  "Sets up Ableton Link instances"
  [version opts]
  (reify db/DB
    (setup! [_ test node]
      (c/su
        (debian/install [:autoconf
                         :build-essential
                         :cmake
                         :git
                         :libssl-dev
                         :netcat
                         :ruby-dev
                         :rubygems
                         :libglib2.0-dev
                         :wget])
        (info "Installing packages (this takes several minutes)")
        (c/cd "/"
              (when-not (cu/exists? "ruby_ableton_link")
                (info "Cloning https://github.com/xavriley/ruby_ableton_link.git")
                (c/exec :git :clone "https://github.com/xavriley/ruby_ableton_link.git"))
              (c/cd "/ruby_ableton_link"
                    (c/exec :git :pull :origin :master)
                    (c/exec :git :submodule :update :--init :--recursive)
                    ;; enable debugging log in Link library
                    (c/cd "ext/ableton_link/link"
                          (c/exec (c/lit "sed -i 's/util::NullLog/util::StdLog/g' include/ableton/platforms/Config.hpp")))
                    (c/exec :gem :install :bundler)
                    (c/exec :bundle :install)
                    (c/exec :rake :compile)
                    (c/exec :iptables :-Z) ;; reset packet counters

                    ;; allow peer discovery to stabilize
                    (do
                      ;; This is a barrier
                      ;; They all wait until all nodes have hit this
                      ;; We then sleep for an amount of time based on their node id
                      ;; This allows us to determine that n1 should always be the leader
                      (core/synchronize test)
                      (info node (str "Sleeping for " (* (read-string (re-find #"\d" node)) 1000) " ms"))
                      (Thread/sleep (* (read-string (re-find #"\d" node)) 2000))

                      (info node "Link installed - starting test")
                      (c/exec (c/lit "bin/server > /link.log 2>&1 &")))))))

    (teardown! [_ test node]
      (c/su
        ;; exit gracefully from the process to avoid failing the test
        (c/exec (c/lit "echo 'quit' | nc localhost 17001"))
        (cond (:no-teardown opts) (info node "NOT tearing down link")
              :else (do
                      (c/exec (c/lit "rm -rf /ruby_ableton_link"))
                      (info node "tearing down link")))))

    db/LogFiles
    (log-files [_ test node]
      [logfile "/iptables.log"])))

(defn r   [_ _] {:type :invoke, :f :read, :value nil})
(defn w   [_ _] {:type :invoke, :f :write, :value (+ 20 (rand-int 200))})

(defrecord Client [conn]
  client/Client
  (open! [this test node]
    (assoc this :node node))

  (setup! [this test])

  (invoke! [this test op]
    (case (:f op)
        :read (assoc op :type :ok,
                     ;; to read we shell out to netcat sending the string "status"
                     ;; to port 17001 on the node, which returns the current tempo
                     ;; of that node as a string. This is parsed as a number with
                     ;; read-string and then rounded to an integer to avoid issues around
                     ;; floating point precision within the Ruby library that wraps the
                     ;; Ableton Link library
                     :value (java.lang.Math/round (read-string (:out (shell/sh "nc" "-q" "1" (name (:node this)) "17001" :in "status")))))
        :write (do (shell/sh "nc" "-q" "1" (name (:node this)) "17001" :in (str "tempo " (:value op)))
                 (assoc op :type, :ok))
        ;; connect to all nodes and add a rule so that udp traffic is counted by iptables
        :setup-packet-logging (do (c/with-test-nodes test
                                    (doseq [hostname ["n1" "n2" "n3" "n4" "n5"]]
                                      (info (cn/ip hostname))
                                      (c/su (c/exec (c/lit (str "iptables -I INPUT -p udp -s " (cn/ip hostname) " -m comment --comment \"Logging UDP from " (cn/ip hostname) "\""))))
                                      (c/su (c/exec (c/lit (str "iptables -I OUTPUT -p udp -m comment --comment \"Logging outgoing UDP\""))))))
                                  (assoc op :type, :info))
        ;; connect to all nodes in test and ask them to log their packet data
        :log-packet-data (do (c/with-test-nodes test
                               (c/su (c/exec (c/lit "iptables -vL > /iptables.log"))))
                             (assoc op :type, :info))))

  (teardown! [this test])

  (close! [_ test]))

;; taken from https://github.com/jepsen-io/jepsen/blob/8cf63da6204c4ebc72b45546298dc74c028885bd/cockroachdb/src/jepsen/cockroach/nemesis.clj#L152
(defn slowing
  "Wraps a nemesis. Before underlying nemesis starts, slows the network by dt
  s. When underlying nemesis resolves, restores network speeds."
  [nem dt]
  (reify nemesis/Nemesis
    (setup! [this test]
      (net/fast! (:net test) test)
      (nemesis/setup! nem test)
      this)

    (invoke! [this test op]
      (case (:f op)
        :start (do (info "slowing down network by " dt " seconds")
                   (net/slow! (:net test) test {:mean (* dt 1000) :variance 1})
                   (nemesis/invoke! nem test op))

        :stop (try (do (info "removing artificial network delay")
                       (nemesis/invoke! nem test op))
                   (finally
                     (net/fast! (:net test) test)))

        (nemesis/invoke! nem test op)))

    (teardown! [this test]
      (net/fast! (:net test) test)
      (nemesis/teardown! nem test))))

(defn line-grudge
  "A grudge where every connection is a bridge"
  [nodes]
  (do
    (info "Line grudge " nodes)
    (->> (into (sorted-set) nodes)
       (partition 2 1) ;; outputs [[n1 n2], [n2 n3] ...]
       (take (count nodes))
       (map (fn [pair] [(first pair) #{(last pair)}]))
       (into {}))))

(defn partition-line
  "Partition nodes so that every connection is a bridge"
  []
  (nemesis/partitioner line-grudge))

(defn choose-nemesis
  "Choose nemesis based on command line options"
  [opts]
  (let [partition-fn (case (:topology opts)
                       "line" (partition-line)
                       "ring" (nemesis/partition-majorities-ring)
                       "bridge" (nemesis/partitioner nemesis/bridge)
                       "connected" nemesis/noop)
        bandwidth-fn (if (:network-delay opts)
                       #(slowing %1 (:network-delay opts))
                       ;; else
                       nil)]
    (if bandwidth-fn
      (bandwidth-fn partition-fn)
      ;; else
      partition-fn)))

(defn link-test
  "Given an options map from the command line runner (e.g. :nodes, :ssh,
  :concurrency, ...) constructs a test map"
  [opts]
  (merge tests/noop-test
         opts
         {:name "link"
          :os debian/os
          :db (db "0.0.1" opts)
          :client (Client. nil)
          :model (model/register)
          :checker (checker/compose
                     {:perf (checker/perf)
                      :linear (checker/linearizable)
                      :timeline (timeline/html)})
          :nemesis (choose-nemesis opts)
          :generator (gen/phases (gen/on #{1} (gen/once {:type :info, :f :setup-packet-logging}))
                                 (->>
                                   (gen/seq
                                     (cycle [(gen/once {:type :invoke, :f :write, :value 120})
                                             (gen/seq (cycle [r w w]))]))
                                   (gen/delay (:delay opts))
                                   (gen/singlethreaded)
                                   (gen/nemesis (gen/seq (cycle
                                                           [(gen/sleep (:nemesis-duration opts))
                                                            {:type :info, :f :start}
                                                            (gen/sleep (:nemesis-duration opts))
                                                            {:type :info, :f :stop}])))
                                   ;; Time limit feels like a more intuitive way to test
                                   ;; rather than using the concept of the number of operations
                                   ;; The following gives a compromise - an exact number of operations
                                   ;; (for consistent test results) but with a notion of how long these
                                   ;; will take
                                   (gen/limit (/ (:time-limit opts) (:delay opts))))
                                 (gen/barrier (gen/once {:type :info, :f :log-packet-data}))
                                 (gen/sleep 5))}))

(def cli-opts
  "Additional command line options."
    [["-d" "--delay SECS" "Delay between read/write operations."
      :default 2]
     [nil "--nemesis-duration SECS" "Length of the window between nemesis start/stop"
      :default 5]
     ["-t" "--topology TOPOLOGY" "Topology of partition for nemesis"
      :default "connected"]
     [nil "--network-delay SECS" "Delay to introduce to packets between nodes"
      :parse-fn read-string]
     [nil "--no-teardown" "Don't remove build of gem in teardown"]])

(defn -main
  "Handles command line arguments. Can either run a test, or a web server for
  browsing results."
  [& args]
  (do (shell/sh "apt-get" "install" "-qy" "netcat") ;; bit of a hack as we shell out to nc on the control node
      (cli/run! (cli/single-test-cmd {:test-fn link-test
                                      :opt-spec cli-opts})
                args)
      ;; run custom reporting from Ruby script
      (shell/sh "grep -Hn '^' store/latest/{history.edn,n*/link.log} | ruby tempo-grapher.rb")))
