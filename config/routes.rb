Rails.application.routes.draw do
  root 'sessions#new'

  get '/pictures/show', to: 'pictures#show'
  get '/users/current', to: 'users#current'

  resource :users
  resource :pictures
  resource :session, only: [:new, :create, :destroy]
end