Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "informations", to: "pages#informations"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:show]
  get "score", to: "users#score"
  get 'intro', to: 'users#intro', as: 'intro'

  resources :recycling_spot_infos, only: :index
  # resources :users, except: [:index, :new, :create]

  resources :products, only: [:index, :new, :create, :show, :destroy] do
    resources :recycling_spots, only: [:index]
  end

  resources :recycling_spots, only: [:show]
  get "map", to: "recycling_spots#list"
  # Defines the root path route ("/")
  # root "posts#index"
end
