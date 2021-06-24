Rails.application.routes.draw do
  get 'users/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  begin
    ActiveAdmin.routes(self)
  rescue StandardError
    ActiveAdmin::DatabaseHitDuringLoad
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :users do
    post "token" => "users/refresh#create"
  end

  devise_for :users,
             path: "",
             path_names: {
               sign_in: "login",
               sign_out: "logout",
               registration: "signup"
             },
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"
             }

  resources :categories, only: [:index, :create, :show]
  resources :items, only: [:index, :show]
  resources :images do
    post :dropzone, on: :collection
  end

  resources :carts
  resources :interests, except: :update
  resources :orders, only: [:index, :create]
  resources :items do
    resources :reviews, except: :update
  end

  resources :users, only: :update
  
end
