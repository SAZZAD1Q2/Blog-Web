require 'rails_helper'

RSpec.describe 'users#index', type: :feature do
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

    visit users_url
  end

  describe '#indexpage' do
    it 'can see the username of all other users.' do
      expect(page).to have_content(@users[0].name)
      expect(page).to have_content(@users[1].name)
    end

    it 'I can see the profile picture for each user.' do
      @users.each do |user|
        expect(page).to have_css("img[src='#{user.photo}']")
      end
    end

    it 'I can see the number of posts each user has written.' do
      @users.each do |user|
        expect(page).to have_content("Number of posts: #{user.post_counter}")
      end
    end

    it 'When I click on a user, I am redirected to that user show page.' do
      click_link(@users[0].name)
      expect(page).to have_current_path(user_path(@users[0].id))
    end
  end
end

