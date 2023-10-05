require 'rails_helper'

RSpec.describe 'users#show page', type: :feature do
  before(:each) do
    @user1 = User.create(
      name: 'Cosmas',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Web developer from Uganda',
      post_counter: 0
    )

    @user2 = User.create(
      name: 'Martin',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Software developer.',
      post_counter: 0
    )

    @posts = [
      Post.create(author: @user1, title: 'My test post', text: 'this is a test post1'),
      Post.create(author: @user1, title: 'My test post2', text: 'this is a test post2'),
      Post.create(author: @user1, title: 'My test post3', text: 'this is a test post3')
    ]

    visit users_path
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
      expect(page).to have_content("Number of posts: #{User.find(@user1.id).post_counter}")
    end

    it 'I can see the user bio.' do
      expect(page).to have_content(@user1.bio.to_s)
    end

    it 'I can see the user first 3 posts.' do
      @user1.posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'can see a button to view all user posts' do
      expect(page).to have_selector('a', text: 'See all posts')
    end
  end

  describe 'GET/posts/show' do
    it 'When I click to see all posts, it redirects me to the user posts index page.' do
      visit user_path(@user1)
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user1))
    end
  end
end
