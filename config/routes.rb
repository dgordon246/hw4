Rails.application.routes.draw do
  resources "entries"
  resources "places"
  resources "users"
  resources "sessions"

  get("/login", { :controller => "sessions", :action => "new" })
  get("/logout", { :controller => "sessions", :action => "destroy" })

  get("/", { :controller => "entries", :action => "index" })
end
