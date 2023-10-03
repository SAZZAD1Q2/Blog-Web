# rubocop:disable all
class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  validates :title, presence: true, length: { maximum: 250 }
  validates :comment_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :like_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_author_post_counter

  attribute :comment_counter, :integer, default: 0
  attribute :like_counter, :integer, default: 0

  def recent_comments_post(limit)
    self.comments.order(created_at: :desc).limit(limit)
  end

  private

  def update_author_post_counter
    author.update_columns(post_counter: author.posts.count)
  end
end
