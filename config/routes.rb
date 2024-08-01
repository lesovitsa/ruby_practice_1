Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
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

  # users
  resource :users, only: [:create]
  post "/register", to: "auths#create_client"
  post "/login", to: "auths#login"
  post "/admin/add_admin", to: "auths#add_admin"
  post "/admin/add_client", to: "auths#add_client"

  # brands
  post "/brands/register", to: "brands#register"
  patch "/brands/update", to: "brands#update_brand"

  # products
  post "/products/register", to: "products#register"
  patch "/products/update", to: "products#update_product"

  # brand_ownerships
  post "/brand/product/add", to: "brand_ownerships#add_product_to_brand"
  delete "/brand/product/remove", to: "brand_ownerships#remove_product_from_brand"

  # client products
  post "/client/product/add", to: "client_products#add_product_to_client"
  delete "/client/product/remove", to: "client_products#remove_product_from_client"
  patch "/client/product/set_payout_rate", to: "client_products#set_payout_rate"
  patch "/client/product/set_state", to: "client_products#set_state"
  get "/client/products/all", to: "client_catalogs#get_all"
  get "/client/products/product_id", to: "client_catalogs#get_by_product_id"
  get "/client/products/brand_id", to: "client_catalogs#get_by_brand_id"
end
