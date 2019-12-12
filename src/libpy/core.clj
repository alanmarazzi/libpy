(ns libpy.core
  (:require
   [libpython-clj.python :as py]))

(def original (System/getProperty "java.library.path"))

(defn reset-path!
  []
  (System/setProperty "java.library.path" original))

(defn get-python-path
  []
  (System/getenv "PYTHONHOME"))

(defn disassemble-path
  []
  (->
    (System/getProperty "java.library.path")
    (clojure.string/split #":")))

(defn sanitize-path
  [path ending]
  (if (clojure.string/ends-with? path "/")
    (str path ending)
    (str path "/" ending)))

(defn generate-paths
  [path]
  (let [lib (sanitize-path path "lib")
        bin (sanitize-path path "bin")]
    [path lib bin]))

(defn prepend-path
  [path]
  (let [paths (generate-paths path)
        rev (disassemble-path)]
    (apply merge paths rev)))

(defn set-python-path!
  [path]
  (let [np (prepend-path path)]
    (System/setProperty "java.library.path"
      (clojure.string/join ":" np))))

(defn -main
  []
  (set-python-path! (get-python-path))
  (py/initialize!)
  (println (py/->py-list [1 2 3])))