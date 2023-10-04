require 'rails_helper'

RSpec.describe 'users#show page', type: :feature do
  before(:each) do
    User.destroy_all # Destroy all existing users to start with a clean slate

    @user1 = User.create(
      name: 'Sazzad',
      photo: 'http://via.placeholder.com/250x250',
      bio: 'A programmer from Bangladesh.',
      post_counter: 0
    )

    @user2 = User.create(
      name: 'Saif',
      photo: 'http://via.placeholder.com/250x250',
      bio: 'A programmer from Narail.',
      post_counter: 0
    )

    @posts = [
      Post.create(author: @user1, title: 'Arrival', text: 'Post content 1',
                  comment_counter: 0, like_counter: 0),
      Post.create(author: @user1, title: 'Departure', text: 'Post content 2',
                  comment_counter: 0, like_counter: 0),
      Post.create(author: @user1, title: 'Reverse', text: 'Post content 3',
                  comment_counter: 0, like_counter: 0)
    ]

    visit user_path(@user1)
  end
  describe 'show page' do
    before(:each) do
      visit user_path(@user1)
    end

    it 'can see the user profile picture.' do
      expect(page).to have_css("img[src='#{@user1.photo}']")
    end

    it 'can see the user username' do
      expect(page).to have_content(@user1.name.to_s)
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content("Number of posts: #{@user1.post_counter}")
    end

    it 'I can see the user bio.' do
      expect(page).to have_content(@user1.bio.to_s)
    end

    it 'I can see the user first 3 posts.' do
      @user1.recent_posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'can see a button to view all user posts' do
      expect(page).to have_selector('button', text: 'See all posts')
    end
  end
  describe 'GET/posts/show' do
    it 'When I click a user post, it redirects me to that post show page' do
      visit user_path(@user1)

      post = @user1.recent_posts.first
      click_link(post.id)
      expect(page).to have_current_path(user_post_path(@user1, post))
    end

    it 'When I click to see all posts, it redirects me to the user posts index page.' do
      visit user_path(@user1)
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user1))
    end
  end
end