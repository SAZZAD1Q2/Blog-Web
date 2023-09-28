class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id]) # Assuming the parameter name is post_id
    @like = Like.new(user: current_user, post: @post)

    if @like.save
      flash[:success] = 'Liked successfully!'
    else
      flash[:alert] = 'Something went wrong'
    end

    redirect_to user_post_path(current_user, @post)
  end
end
