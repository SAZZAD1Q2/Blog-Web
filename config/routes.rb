# frozen_string_literal: true

Rails.application.routes.draw do
  get 'likes/create'
  get 'comments/create'
  get 'posts/index'
  get 'posts/show'
  get 'posts/new'
  get 'posts/create'
  get 'users/index'
  get 'users/show'
 
end
