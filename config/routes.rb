Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts

  get '/posts/:index', to: "posts#show"
  post '/posts/:new_threads', to: "posts#new_threads"
  root 'posts#index'
end
