require 'rails_helper'

RSpec.describe 'posts#show', type: :feature do
  before(:each) do
    @user_one = User.create(
      name: 'Cosmas',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Web developer from Uganda',
      post_counter: 0
    )

    @posts = [
      @post1 = Post.create(
        author: @user_one,
        title: 'Blog1',
        text: 'This is my first post'
      ),
      @post2 = Post.create(
        author: @user_one,
        title: 'Blog2',
        text: 'This is my second post'
      )
    ]
    visit user_post_path(user_id: @user_one.id, id: @post1.id)
  end

  describe 'show page' do
    it 'should see title of the post' do
      expect(page).to have_content(@post1.title.to_s)
    end

    it 'I can see who wrote the post.' do
      expect(page).to have_content(@user_one.name.to_s)
    end

    it 'I can see how many comments it has' do
      expect(page).to have_content("Comments: #{Post.find(@post1.id).comments.count}")
    end

    it 'I can see how many likes a post has' do
      expect(page).to have_content("Likes: #{Post.find(@post1.id).likes.count}")
    end

    it 'should see body of the post' do
      expect(page).to have_content(@post1.text.to_s)
    end

    it 'I can see the username of each commenter' do
      @post1.comments.each do |comment|
        expect(page).to have_content(comment.user.name)
      end
    end

    it 'I can see the comment each commenter left.' do
      @post1.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
