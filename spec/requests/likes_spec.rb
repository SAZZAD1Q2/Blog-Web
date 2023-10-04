# require 'rails_helper'

# RSpec.describe Like, type: :model do
#   describe 'associations' do
#     it 'belongs to user' do
#       like = Like.reflect_on_association(:user)
#       expect(like.macro).to eq(:belongs_to)
#     end

#     it 'belongs to post' do
#       like = Like.reflect_on_association(:post)
#       expect(like.macro).to eq(:belongs_to)
#     end
#   end

#   describe 'update_like_counter' do
#     user = User.create(name: 'Microverse  Liker', photo: 'http://via.placeholder.com/250x250',
#                        bio: 'Collaboratively')
#     post = Post.create(title: 'test', text: 'post content', author: user, comment_counter: 0, like_counter: 0)
#     subject = Like.create(user: user)

#     it 'increments the likes counter on the associated post' do
#       expect { subject.send(:update_like_counter) }.to change { post.reload.like_counter }.by(1)
#     end
#   end
# end
