Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :frames do
    resources :frame_prices
  end
  resources :lenses do
    resources :lenses_prices
  end
  
  put '/change_currency', to: 'currency#change_currency'
  post '/basket', to: 'basket#add_item'
  delete '/basket/:item_no', to: 'basket#remove_item'
  get '/basket', to: 'basket#index'
  get '/basket/:item_no', to: 'basket#show'
  post '/basket/checkout', to: 'basket#checkout_basket'

  resources :users

  post '/user/login', to: 'users#login'
  # Defines the root path route ("/")
  # root "articles#index"
end
