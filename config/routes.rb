Rails.application.routes.draw do
  root 'homes#top'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post   'guest_login', to: "guest_sessions#create"
  resource :user
  resources :facilities do
    resource :favorites, only: [:create, :destroy]
    collection do
      get 'search'
      get 'search_by_area'
    end
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end
  end
end
