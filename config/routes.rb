Rails.application.routes.draw do
  root 'sessions#new'

  get '/auth/github', as: :login
  get '/auth/github/callback', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#index'

  resources :groups, only: [:new, :create, :edit, :update, :destroy] do
    resource :follows, module: :groups, only: [:update, :destroy]
  end

  resources :users, only: [:update] do
    resource :follows, module: :users, only: [:update, :destroy]
  end

end
