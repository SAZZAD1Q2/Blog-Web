# app/models/comment.rb

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def update_post_comments_counter
    post.update(comment_counter: post.comments.count)
  end
end
