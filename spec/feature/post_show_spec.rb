require 'rails_helper'

RSpec.describe 'posts#index', type: :feature do
  before(:each) do
    User.destroy_all # Destroy all existing users to start with a clean slate
    Post.destroy_all # Destroy all existing posts to start with a clean slate

    @user_one = User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.',
      post_counter: 0
    )

    @post1 = Post.create(
      author: @user_one,
      title: 'Blog1',
      text: 'This is my first post',
      comment_counter: 0,
      like_counter: 0
    )

    @post2 = Post.create(
      author: @user_one,
      title: 'Blog2',
      text: 'This is my second post',
      comment_counter: 0,
      like_counter: 0
    )

    visit user_post_path(@user_one, @post1)
  end

  describe 'show page' do
    before(:each) do
      visit user_post_path(@user_one, @post1)
    end

    it 'should see title of the post' do
      expect(page).to have_content(@post1.title)
    end

    it 'I can see who wrote the post.' do
      expect(page).to have_content(@user_one.name)
    end

    it 'I can see how many comments it has' do
      expect(page).to have_content("Comments: #{@post1.comment_counter}")
    end

    it 'I can see how many likes a post has' do
      expect(page).to have_content("Likes: #{@post1.like_counter}")
    end

    it 'should see body of the post' do
      expect(page).to have_content(@post1.text)
    end

    it 'I can see the username of each commenter' do
      @post1.recent_comments.each do |comment|
        expect(page).to have_content(comment.user.name)
      end
    end

    it 'I can see the comment each commenter left.' do
      @post1.recent_comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end

