(import-macros {: route} "macros")
(local fs (require :fs))

(fn create-router [app route-root]
  (let [toplevel (fs.toplevel route-root)
        router
        (fn route-paths [root current-path]
          (let [root (or root route-root)
                current-path (or current-path "/")
                paths (fs.dir root)
                stripped-path (string.gsub (current-path:gsub "^/" "") "/" ".")
                route-name (if (= current-path "/")
                             "index"
                             (.. stripped-path ".index"))]
            (if (not= nil (. paths :index.etlua))
                (route get toplevel route-name current-path :etlua)
                (not= nil (. paths :index.fnl))
                (route get toplevel route-name current-path))
            (each [path _ (pairs paths)]
              (let [fullpath (.. root "/" path)]
                (when (fs.directory? fullpath)
                  (route-paths fullpath
                    (.. current-path (if (not= "/" current-path) "/" "") path)))))))]
    router))


{: create-router}
