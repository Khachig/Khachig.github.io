(fn route [method root name path view-type]
  (assert-compile (sym? method))
  `(,(sym (.. "app:" (tostring method))) ,path
      ,(if (= :etlua view-type)
         `(fn [] {:render ,name})
         `(require (.. ,root "." ,name)))))

{: route}
