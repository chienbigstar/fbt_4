Rails.application.routes.draw do
  root "static_pages#home"
  get "/pages/:page" => "static_pages#show", as: :page
  devise_for :users
  resources :tours, only: :show
  resources :payment, only: [:new,:create]
  resources :bookings, only: [:new, :create]
end
