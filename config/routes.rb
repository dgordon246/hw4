Rails.application.routes.draw do
  resources :places do
    resources :entries, only: [:new, :create]
  end

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"

  root "places#index"
end


