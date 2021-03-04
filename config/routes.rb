Rails.application.routes.draw do
  root to: 'articles#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup',to: 'users#new'
  root to: 'users#index'
  resources :users, except: [:new]
  resources :articles
end
