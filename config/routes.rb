Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  post "/rate" => "rater#create", as: :rate
  root "static_pages#home"
  get "/pages/:page" => "static_pages#show", as: :page
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks#create"}
  namespace :admin do
    resources :places
    resources :bookings, only: [:index, :show, :update]
    resources :reviews, only: [:index, :show, :destroy]
    resources :tours
    resources :tour_rules, except: :show
    resources :users, only: [:index, :destroy]
    resources :final_prices, only: :index
  end
  resources :tours, only: [:index, :show] do
    resources :reviews
  end

  resources :places, only: [:show, :index]
  resources :categories, only: [:index]

  resources :reviews do
    resources :likes, only: [:create, :destroy]
    resources :comments, except: [:show, :new]
  end

  resources :comments, except: [:show, :new] do
    resources :likes, only: [:create, :destroy]
  end
  resources :bookings, only: [:new, :create, :destroy]
  resources :users, only: [:show] do
    resources :orders, only: :index
  end
  resources :activities, only: :index

  get "payments/new", to: "payments#new"
  get "payments/update", to: "payments#update"
  get ":review_id/comments/new/(:parent_id)", to: "comments#new",
    as: :new_review_comment
  get "categories/:tag", to: "tours#index", as: :tag
  get "search(/:search)", to: "searches#index", as: :search
end
