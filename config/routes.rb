Rails.application.routes.draw do

  root 'pages#introduction'
  
  devise_for :users, controllers: {registrations: 'users/registrations', invitations: 'users/invitations'}

  resources :camps do
    member do
      patch :toggle_status
    end
  end

  resources :camp_locations
  resources :camp_applications
  get 'dashboard', to: 'pages#dashboard'
  get 'view_application', to: 'camp_applications#view_application'
  get 'profile', to: 'users#profile'

  namespace 'admin' do
    root 'dashboard#index'
    
    resources :users, except: [:new, :create] do
      get 'search', to: 'users#index', on: :collection
    end
    resources :camp_applications, param: :application_id do
    	get 'view', on: :member
		end
  end
end
