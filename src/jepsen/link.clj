(ns jepsen.link
  (:require [clojure.tools.logging :refer :all]
            [clojure.string :as str]
            [jepsen [cli :as cli]
                    [control :as c]
                    [db :as db]
                    [tests :as tests]]
            [jepsen.control.util :as cu]
            [jepsen.os.debian :as debian]))

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
                    (c/exec :gem :install :bundler)
                    (c/exec :bundle :install)
                    (c/exec :rake :compile)
                    (info node "Link installed - starting test")
                    (c/exec (c/lit "ruby -Ilib -e 'require \"bundler/setup\"; require \"ableton_link\"; link = AbletonLink.new; link.enable; 100.times { puts link.status; sleep link.time_until_subdivision_within_beat(0.0).abs }' > /link.log 2>&1 "))))))

    (teardown! [_ test node]
      (info node "tearing down link"))

    db/LogFiles
    (log-files [_ test node]
      [logfile])))

(defn link-test
  "Given an options map from the command line runner (e.g. :nodes, :ssh,
  :concurrency, ...) constructs a test map"
  [opts]
  (merge tests/noop-test
         opts
         {:name "link"
          :os debian/os
          :db (db "0.0.1")}))

(defn -main
  "Handles command line arguments. Can either run a test, or a web server for
  browsing results."
  [& args]
  (cli/run! (merge (cli/single-test-cmd {:test-fn link-test})
                   (cli/serve-cmd))
            args))
