SampleApp::Application.routes.draw do
  
 
 

  resources :users do 
  	member do
      get :following, :followers, :requests
  
    end
      end

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :requests, only: [:create]

 
  root to:          'static_pages#home'
 
 match '/signup',  to: 'users#new'
 match '/signin',  to: 'sessions#new'	
 match '/signout', to: 'sessions#destroy', via: :delete
 match '/help',    to: 'static_pages#help'
 match '/about',   to: 'static_pages#about'
 #match '/request', to: 'users#requests', via: [:get, :post], as: :requestuser

  
end
