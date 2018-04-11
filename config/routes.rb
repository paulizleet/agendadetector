Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #resources :posts
  resources :chan_boards do
    resources :chan_threads, shallow: true
    resources :posts
  end

  # get '/posts/:index', to: "posts#show"
  # get 'greatest', to: "posts#greatest"
  # root 'posts#index'
  root 'chan_boards#index'
end
