Rails.application.routes.draw do
  root 'sessions#new'

  get '/auth/github', as: :login
  get '/auth/github/callback', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#index'

  resources :groups, only: [:new, :create, :edit, :update, :destroy]

  resources :users, only: [:update]
end
