Rails.application.routes.draw do
  root 'sessions#new'

  get '/auth/github', as: :github_login
  get '/auth/twitter', as: :twitter_login
  get '/auth/:provider/callback', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#index'

  resources :groups, only: [:new, :create, :edit, :update, :destroy] do
    resource :follows, module: :groups, only: [:update, :destroy]
  end

  resources :follows, only: [:create]
  delete :follows, to: 'follows#destroy'
end
