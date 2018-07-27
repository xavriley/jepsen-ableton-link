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
                         :libglib2.0-dev])
        (info "Installing packages (this takes several minutes)")
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
                    (c/exec (c/lit "bin/server > /link.log 2>&1 &"))))))

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
                     ;; unsafe
                     :value (read-string (:out (shell/sh "nc" "-q" "1" (name (:node this)) "17001" :in "status"))))
        :write (do (shell/sh "nc" "-q" "1" (name (:node this)) "17001" :in (str "tempo " (:value op)))
                 (assoc op :type, :ok))))

  (teardown! [this test])

  (close! [_ test]))

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
          :nemesis (nemesis/partitioner (comp nemesis/bridge shuffle))
          :generator (->> (gen/mix [r w])
                          (gen/nemesis (gen/seq (cycle
                                                  [(gen/sleep 10)
                                                   {:type :info, :f :start}
                                                   (gen/sleep 30)
                                                   {:type :info, :f :stop}])))
                          (gen/time-limit 120))}))

(defn -main
  "Handles command line arguments. Can either run a test, or a web server for
  browsing results."
  [& args]
  (cli/run! (merge (cli/single-test-cmd {:test-fn link-test})
                   (cli/serve-cmd))
            args))
