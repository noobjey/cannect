Rails.application.routes.draw do
  root 'sessions#new'

  get '/auth/github', as: :github_login
  # get '/auth/github/callback', to: 'sessions#create'
  get '/auth/twitter', as: :twitter_login
  # get '/auth/twitter/callback', to: 'twitter#create'

  delete 'logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#index'

  resources :groups, only: [:new, :create, :edit, :update, :destroy] do
    resource :follows, module: :groups, only: [:update, :destroy]
  end

  # make follows a concern
  # concern :commentable do
  #   resources :comments
  # end
  # resources :messages, concerns: :commentable


  resources :users, only: [:update] do
    resource :follows, module: :users, only: [:update, :destroy]
  end

  get '/auth/:provider/callback', to: 'sessions#create'

  resources :follows, only: [:create, :destroy]

end
