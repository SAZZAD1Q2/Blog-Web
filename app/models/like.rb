# app/models/like.rb

class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def update_post_like_counter
    post.update(like_counter: post.likes.count)
  end
end
