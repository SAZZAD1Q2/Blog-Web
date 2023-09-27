class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User' # Use 'User' or the correct class name for your User model
  belongs_to :post

  after_save :update_comments_counter

  private

  def update_comments_counter
    post.increment!(:comment_counter)
  end
end
# To add a comment, please run the following command. It will go well:
# Comment.create(user: second_user, post: first_post, text: 'Hi Tom!')
