Rails.application.routes.draw do
  root 'sessions#new'
  get '/list', to: 'pictures#list'

  resources :users, except: [:index, :show] do
    # resources :contacts, shallow: true
  end

  get '/users/current', to: 'users#current'

  resource :session, only: [:new, :create, :destroy]
end