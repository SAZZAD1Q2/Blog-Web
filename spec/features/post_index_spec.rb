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

    @posts = [
      Post.create(
        author: @user_one,
        title: 'Blog1',
        text: 'This is my first post'
      ),
      Post.create(
        author: @user_one,
        title: 'Blog2',
        text: 'This is my second post'
      )
    ]

    visit user_posts_url(user_id: @user_one.id)
  end

  describe '#Indexpage' do
    it 'can see the user profile picture.' do
      expect(page).to have_css("img[src='#{@user_one.photo}']")
    end
    it 'I can see the user username.' do
      expect(page).to have_content(@user_one.name.to_s)
    end
    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content(@user_one.post_counter.to_s)
    end

    it 'should see title of the post' do
      @posts.each do |post|
        expect(page).to have_content(post.title.to_s)
      end
    end

    it 'should see body of the post' do
      @posts.each do |post|
        expect(page).to have_content(post.text.to_s)
      end
    end

    it 'I can see the first comments on a post.' do
      @posts.each do |post|
        post.recent_comments.each do |comment|
          expect(page).to have_content(comment.user.text)
        end
      end
    end
    it 'I can see how many comments a post has' do
      @posts.each do |post|
        expect(page).to have_content("Comments:#{post.comment_counter}")
      end
    end
    it 'I can see how many likes a post has' do
      @posts.each do |post|
        expect(page).to have_content("Likes:#{post.like_counter}")
      end
    end
  end
  describe 'GET show/page' do
    it 'When I click on a post, I am redirected to that postshow page.' do
      visit user_posts_url(user_id: @user_one.id)
      post = @posts.first
      click_link(post.id)
      expect(page).to have_current_path(user_post_path(@user_one.id, post.id))
    end
  end
end

