SampleApp::Application.routes.draw do
  
 
 

 

 get 'password_resets/new'

  resources :users do 
  	member do
      get :following, :followers, :requests

  
    end
      end

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :requests do

   member do 

       put :cancel


     end
     end    


  	  



  		

 
  root to:          'static_pages#home'
 
 match '/signup',  to: 'users#new'
 match '/signin',  to: 'sessions#new'	
 match '/signout', to: 'sessions#destroy', via: :delete
 match '/help',    to: 'static_pages#help'
 match '/about',   to: 'static_pages#about'
 

  
end
