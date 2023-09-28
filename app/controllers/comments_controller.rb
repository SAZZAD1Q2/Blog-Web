class CommentsController < ApplicationController
  # ...

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      # Update the comment_counter attribute
      @post.update(comment_counter: @post.comments.count)
      redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
    else
      redirect_to new_user_post_comment_path(user_id: @post.author_id, post_id: @post.id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
