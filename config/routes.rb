Rails.application.routes.draw do
  resources :camp_locations
  devise_for :users
  resources :users, except: [:new, :create] do
    get 'search', to: 'users#index', on: :collection
  end

  get 'profile', to: 'users#profile'
  root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
