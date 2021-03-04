Rails.application.routes.draw do
  resources :camps do
    member do
      patch :toggle_status
      get :introduction
    end
  end
  resources :camp_locations
  devise_for :users
  resources :users, except: [:new, :create] do
    get 'search', to: 'users#index', on: :collection
  end

  get 'profile', to: 'users#profile'
  root 'pages#home'
  namespace 'admin' do
    root 'dashboard#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
