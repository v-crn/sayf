Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/tos', to: 'static_pages#tos'
  get  '/privacy', to: 'static_pages#privacy'
  get  '/new_sayings', to: 'static_pages#new_sayings'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'profile_edit', to: 'users/registrations#profile_edit', as: 'profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'
  end
  resources :users do
    member do
      get :following, :followers
      get :favorite_sayings
    end
  end
  resources :sayings, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  resources :favorites, only: %i[create destroy]
end
