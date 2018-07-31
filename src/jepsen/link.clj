(ns jepsen.link
  (:require [clojure.tools.logging :refer :all]
            [clojure.string :as str]
            [clojure.java.shell :as shell]
            [jepsen [checker :as checker]
                    [cli :as cli]
                    [client :as client]
                    [control :as c]
                    [db :as db]
                    [generator :as gen]
                    [nemesis :as nemesis]
                    [net :as net]
                    [tests :as tests]]
            [jepsen.checker.timeline :as timeline]
            [jepsen.control.util :as cu]
            [jepsen.os.debian :as debian]
            [knossos.model :as model]))

;; constants
(def logfile (str "/link.log"))

(defn db
  "Sets up Ableton Link instances"
  [version]
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
        ;; (c/exec (c/lit "wget -O toxiproxy-2.1.3.deb https://github.com/Shopify/toxiproxy/releases/download/v2.1.3/toxiproxy_2.1.3_amd64.deb"))
        ;; (c/exec (c/lit "dpkg -i toxiproxy-2.1.3.deb"))
        ;; (c/exec (c/lit "service toxiproxy start"))
        (c/cd "/"
              (when-not (cu/exists? "ruby_ableton_link")
                (info "Cloning https://github.com/xavriley/ruby_ableton_link.git")
                (c/exec :git :clone "https://github.com/xavriley/ruby_ableton_link.git"))
              (c/cd "/ruby_ableton_link"
                    (c/exec :git :submodule :update :--init :--recursive)
                    ;; enable debugging log in Link library
                    (c/cd "ext/ableton_link/link"
                          (c/exec (c/lit "sed -i 's/util::NullLog/util::StdLog/g' include/ableton/platforms/Config.hpp")))
                    (c/exec :gem :install :bundler)
                    (c/exec :bundle :install)
                    (c/exec :rake :compile)
                    (info node "Link installed - starting test")
                    (c/exec (c/lit "bin/server > /link.log 2>&1 &")))))
      ;; allow peer discovery to stabilize
      (Thread/sleep 5000))

    (teardown! [_ test node]
      (c/su
        ;; exit gracefully from the process to avoid failing the test
        (c/exec (c/lit "echo 'quit' | nc localhost 17001"))
        (c/exec (c/lit "rm -rf /ruby_ableton_link")))
      (info node "tearing down link"))

    db/LogFiles
    (log-files [_ test node]
      [logfile])))

(defn r   [_ _] {:type :invoke, :f :read, :value nil})
(defn w   [_ _] {:type :invoke, :f :write, :value (+ 20 (rand-int 200))})

;; this may not be relevant
;; (defn cas [_ _] {:type :invoke, :f :cas, :value [(rand-int 5) (rand-int 5)]})

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
                 (assoc op :type, :ok))))

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
        :start (do (net/slow! (:net test) test {:mean (* dt 1000) :variance 1})
                   (nemesis/invoke! nem test op))

        :stop (try (nemesis/invoke! nem test op)
                   (finally
                     (net/fast! (:net test) test)))

        (nemesis/invoke! nem test op)))

    (teardown! [this test]
      (net/fast! (:net test) test)
      (nemesis/teardown! nem test))))

(defn link-test
  "Given an options map from the command line runner (e.g. :nodes, :ssh,
  :concurrency, ...) constructs a test map"
  [opts]
  (merge tests/noop-test
         opts
         {:name "link"
          :os debian/os
          :db (db "0.0.1")
          :client (Client. nil)
          :model (model/register)
          :checker (checker/compose
                     {:perf (checker/perf)
                      :linear (checker/linearizable)
                      :timeline (timeline/html)})
          :nemesis (slowing (nemesis/partition-majorities-ring)
                            0.5) ;; slow packets - works out as 2x this value because of round trips
          :generator (->>
                          (gen/seq
                            (cycle [(gen/once {:type :invoke, :f :write, :value 120})
                                    (gen/mix [r w])]))
                          (gen/delay 2)
                          (gen/singlethreaded)
                          (gen/nemesis (gen/seq (cycle
                                                  [(gen/sleep 5)
                                                   {:type :info, :f :start}
                                                   (gen/sleep 5)
                                                   {:type :info, :f :stop}])))
                          (gen/time-limit (:time-limit opts)))}))

(defn -main
  "Handles command line arguments. Can either run a test, or a web server for
  browsing results."
  [& args]
  (do (shell/sh "apt-get" "install" "-qy" "netcat") ;; bit of a hack as we shell out to nc on the control node
      (cli/run! (merge (cli/single-test-cmd {:test-fn link-test})
                       (cli/serve-cmd))
                args)))
