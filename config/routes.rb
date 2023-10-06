Rails.application.routes.draw do
  devise_for :users, controllers: { unlocks: 'unlocks' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Root route, you can change this to your desired root path.
  # By default, it's set to the "users#index" action.
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  resources :posts, only: [:new, :create, :destroy]
  resources :comments, only: [:destroy]

  post '/posts/:post_id/comments', to: 'comments#create', as: 'post_comments'
  post '/posts/:post_id/likes', to: 'likes#create', as: 'post_likes'

  # Add a custom route for unlocking accounts
  get '/unlock', to: 'unlocks#new', as: 'new_unlock'
  post '/unlock', to: 'unlocks#create', as: 'unlock'
end
