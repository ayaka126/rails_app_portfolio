Rails.application.routes.draw do
  root   'top#index'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resource :user
  resources :facilities
end
