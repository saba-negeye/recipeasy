Rails.application.routes.draw do
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
  get "/recipes/search", to: "recipes#search", as: "search_recipes"

  # Defines the root path route ("/")
  # root "posts#index"
  root "pages#home"

  resources :users
  resources :recipes do
    collection do
      post "create_from_form"
      post "create_from_api"
    end
  end
  resources :ingredients
  resources :shopping_lists, only: [ :show, :edit, :update ] do
    resources :shopping_list_ingredients, only: [ :create, :destroy ]
  end
  post "recipes/save", to: "recipes#save"
end
