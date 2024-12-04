Rails.application.routes.draw do
  get "ingredients/index"
  get "ingredients/show"
  get "ingredients/new"
  get "ingredients/edit"
  get "ingredients/create"
  get "ingredients/update"
  get "ingredients/destroy"

  devise_for :users
  get "pages/home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # route will capture the search term (ingredient) from the user and pass it to the controller
  get '/recipes/search', to: 'recipes#search', as: 'search_recipes'

  # Defines the root path route ("/")
  # root "posts#index"
  root "pages#home"

  resources :users
  resources :recipes
  resources :ingredients
  resources :shopping_lists, only: [:show, :create, :edit, :update]
 
end
