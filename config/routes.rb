Rails.application.routes.draw do
  root 'homes#top'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resource :user
  resources :facilities do
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end
  end
end
