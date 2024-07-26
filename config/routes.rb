Rails.application.routes.draw do
  resources :follows
  devise_for :users
  root "users#index"
  resources :users do
    resources :tweets
  end
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
end
