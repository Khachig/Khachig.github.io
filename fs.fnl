(local fstat (require :fstat))

(fn string-split [str]
  (collect [s (str:gmatch "[^\r\n]+")] s true))

(fn dir [root]
  (let [handle (io.popen (.. "ls " root))
        paths (handle:read "*a")]
    (handle:close)
    (string-split paths)))

(fn file? [path]
  (= :file (. (fstat path) :type)))

(fn directory? [path]
  (= :directory (. (fstat path) :type)))

(fn ext [path]
  (path:match "^.+(%..+)$"))

(fn basename [path]
  (path:match "^(.+)%..+$"))

(fn toplevel [path]
  (path:match "^([^/]+)"))

{: dir : file? : directory? : ext : basename : toplevel}
