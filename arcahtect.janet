(defn- flagify
  ``
  Turn a keyword or a string into a flag-style string 

  Ex.
  --- 
  :my-kw -> --my-kw
  :f -> -f
  ``
  [x]
  (if (= (length x) 1)
    (string "-" x)
    (string "--" x)))

#
# LET
# :option = a single string or key-value pair, to be translated into a flag or flag-value pair respectively.
# :container-id = any string that identifies a container
# :path = a path on the relative filesystem
#
# if :required = true, the argument must be present, otherwise consider it 'optional'.
# :list = true indicates a list of the given argument will be provided
(def buildah-commands
  {:add {:format [{:name "options" 
                   :type :option
                   :list true} 
                  {:name "container" 
                   :type :container-id 
                   :required true} 
                  {:name "src" 
                   :type :path 
                   :required true}
                  {:name "srcs"
                   :type :path
                   :list true}
                  {:name "dest"
                   :type :path
                   :list true}]}

   :build {:format [{:name "options" 
                     :type :option
                     :list true} 
                    {:name "context" 
                     :type :path}]}

   :commit {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :config {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :containers {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :copy {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :from {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :images {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :info {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :inspect {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :mount {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :pull {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :push {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :rename {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}
   
    :rm {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

    :rmi {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :run {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :tag {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :umount {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :unshare {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}

   :version {:format [{:name "options" 
                     :type :option
                     :list true
                     :required false} 
                    {:name "context" 
                     :type :path 
                     :list false
                     :required false}]}})

(defn- table-to-flag-sequence [tbl]
  (let [key-to-flag (fn [[x y]] [(flagify x) y])]
    (->> tbl
         pairs
         (map key-to-flag)
         flatten)))

(defn buildah [& args]
  (os/execute ["buildah" ;args] :p))

(defn from-containerfile 
  ``
  Build via buildah bud.
  `args` is a keyword list that will be turned into command line opts.
  ``
  [path &opt args]
  (buildah "bud" ;(flags-arg-command-form path args))

(defn- flags-arg-command-form 
  [arg &opt flag-table]
  [;(table-to-flag-sequence flag-table) arg])

(defn- arg-flags-command-form 
  [arg &opt flag-table]
  [arg ;(table-to-flag-sequence flag-table)])

(defn run [path &opt args] nil)
