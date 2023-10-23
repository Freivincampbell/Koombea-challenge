Rails.application.routes.draw do
  resources :pages, only: [:create, :show]
  devise_for :users

  root to: "home#index"
end
