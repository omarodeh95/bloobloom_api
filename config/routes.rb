Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :frames do
    resources :frame_prices
  end
  resources :lenses do
    resources :lenses_prices
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
