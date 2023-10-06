Rails.application.routes.draw do
  devise_for :users, controllers: { unlocks: 'unlocks' }

  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:new, :create] # Nested comments routes under posts
      post 'likes', to: 'likes#create' # Likes for posts
    end
  end

  resources :posts, only: [:new, :create, :destroy] do
    resources :comments, only: [:destroy] # Nested comments routes under posts
  end

  # Additional routes
  post '/posts/:post_id/likes', to: 'likes#create', as: 'post_likes'
  # Add a custom route for unlocking accounts
  get '/unlock', to: 'unlocks#new', as: 'new_unlock'
  post '/unlock', to: 'unlocks#create', as: 'unlock'
end
