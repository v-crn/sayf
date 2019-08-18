Rails.application.routes.draw do
  devise_for :users, controllers: {
		registrations: 'users/registrations'
	}
	devise_scope :user do
		get 'profile_edit', to: 'users/registrations#profile_edit', as: 'profile_edit'
    patch 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'
	end
	root 'static_pages#home'
	get  '/help',    to: 'static_pages#help'
	get  '/about',   to: 'static_pages#about'
	get  '/contact', to: 'static_pages#contact'
	resources :users do
		member do
			get :following, :followers
		end
	end
	resources :sayings, only: [:create, :destroy]
	resources :relationships, only: [:create, :destroy]
end
