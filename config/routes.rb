Rails.application.routes.draw do
  resources :users do 
    member do 
      post 'my_custom_action'
    end
  end
  
  resources :posts do
    resources :users, only: [:create]
  end

  namespace :user do
    resources :posts, only: [:create]
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end


