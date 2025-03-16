Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create]

  resources :places do
    resources :entries, only: [:new, :create]
  end

  get "/", to: "places#index"
end
