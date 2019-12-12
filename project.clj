(defproject libpy "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "EPL-2.0 OR GPL-2.0-or-later WITH Classpath-exception-2.0"
            :url "https://www.eclipse.org/legal/epl-2.0/"}
  :dependencies [[org.clojure/clojure "1.10.0"]
                 [cnuernber/libpython-clj "1.21"]                 
                 [leiningen-core "2.9.1"]]
  :plugins [[lein-with-env-vars "0.2.0"]]
  :aliases {"python" ["with-env-vars"]}
  :env-vars "python.edn"
  :main libpy.core)