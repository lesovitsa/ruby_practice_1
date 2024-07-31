Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "client_product/index"
      get "client_product/show"
      get "brand_product/index"
      get "brand_product/show"
      get "brand_aproduct/index"
      get "brand_aproduct/show"
      get "product/index"
      get "product/show"
      get "brand/index"
      get "brand/show"
      get "user/index"
      get "user/show"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  resource :users, only: [:create]
  post "/register", to: "auths#create_client"
  post "/login", to: "auths#login"
end
