Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #resources :posts
  resources :chan_boards do
    resources :chan_threads, shallow: true
    resources :posts, only: :show

  end

  resources :posts do
    collection do
      get 'greatest', to: "posts#greatest"
    end
  end
  # get '/posts/:index', to: "posts#show"
  # get 'greatest', to: "posts#greatest"
  # root 'posts#index'
  root 'chan_boards#index'
  get '*unmatched_route', to: 'chan_boards#index'

end
