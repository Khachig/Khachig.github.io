(fn setup-routes [app]
  (app:get "/apiroute" (fn [] "htmx says hi!")))

{: setup-routes}
