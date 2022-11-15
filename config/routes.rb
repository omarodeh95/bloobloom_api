Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :frames do
    resources :frame_prices
  end
  resources :lenses do
    resources :lenses_prices
  end
  
  post '/basket', to: 'basket#add_item'
  put '/basket/change_currency', to: 'basket#change_currency'
  delete '/basket/:item_no', to: 'basket#remove_item'
  get '/basket', to: 'basket#index'
  get '/basket/:item_no', to: 'basket#show'
  post '/basket/checkout', to: 'basket#checkout_basket'

  # Defines the root path route ("/")
  # root "articles#index"
end
