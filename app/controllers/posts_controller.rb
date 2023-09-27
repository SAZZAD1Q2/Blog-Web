# rubocop:disable all
class PostsController < ApplicationController
  def index; end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show; end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @user = User.find(params[:user_id])
  end
end
