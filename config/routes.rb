Rails.application.routes.draw do

  root 'pages#introduction'
  get 'dashboard', to: 'pages#dashboard'

  devise_for :users

  resources :camps do
    member do
      patch :toggle_status
    end
  end

  resources :users, except: [:new, :create] do
    get 'search', to: 'users#index', on: :collection
  end

  resources :camp_locations

  resources :camp_applications
  get 'view_application', to: 'camp_applications#view_application'
  get 'profile', to: 'users#profile'

  namespace 'admin' do
    root 'dashboard#index'
    
    resources :camp_applications, param: :application_id do
    	get 'view', on: :member
		end
  end

end
