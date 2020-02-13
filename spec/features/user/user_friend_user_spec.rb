require 'rails_helper'

RSpec.describe "as a user", :vcr do
  it "friends a foller or following by clicking link" do
  OmniAuth.config.test_mode = true
  user_1 = create(:user, token: ENV['GITHUB_TOKEN'])
  user_2 = create(:user, github_handle: 'rer7891')
  user_2 = create(:user)
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    :provider => 'github',
    :credentials => {:token => ENV['GITHUB_TOKEN']},
    :extra => {
      :raw_info => {
        :login => "madelynrr"
      }
    }
  })

  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

  visit '/dashboard'
  within ".github" do
    expect(page).to have_content("Followers")
    within "#follower-rer7891" do
      expect(page).to have_link("rer7891")
      click_link "Add as Friend"
    end
  end
  expect(current_path).to eq('/dashboard')
  expect(page).to have_content("Friend Added")
  expect(user_1.friendships.count).to eq(1)
  end
end
