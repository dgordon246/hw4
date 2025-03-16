Rails.application.routes.draw do
  resources :places do
    resources :entries, only: [:new, :create]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get("/login", { :controller => "sessions", :action => "new" })
  delete("/logout", { :controller => "sessions", :action => "destroy" })
  
  root "places#index"
end