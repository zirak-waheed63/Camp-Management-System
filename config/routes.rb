Rails.application.routes.draw do
  root 'pages#dashboard'
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
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
