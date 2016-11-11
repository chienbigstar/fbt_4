Rails.application.routes.draw do
  root "static_pages#home"
  get "/pages/:page" => "static_pages#show", as: :page
  devise_for :users

  namespace :admin do
    resources :categories
  end
  resources :tours, only: :show
  resources :bookings, only: [:new, :create]
  get "payment/new", to: "payment#new"
  get "payment/update", to: "payment#update"
end
