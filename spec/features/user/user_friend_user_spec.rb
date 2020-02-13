require 'rails_helper'

RSpec.describe "as a user", :vcr do
  it "friends a follower or following by clicking link" do
  OmniAuth.config.test_mode = true
  user_1 = create(:user, token: ENV['GITHUB_TOKEN'])
  user_2 = create(:user, github_handle: 'rer7891')
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

  it "displays all friends on dashboard", :vcr do
    OmniAuth.config.test_mode = true
    user_1 = create(:user)
    user_2 = create(:user, github_handle: 'rer7891')
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
    click_link "Login Through Github"

    within ".github" do
      expect(page).to have_content("Followers")
      within "#follower-rer7891" do
        expect(page).to have_link("rer7891")
        click_link "Add as Friend"
      end
    end

    expect(current_path).to eq('/dashboard')

    within "#friends" do
      expect(page).to have_content('rer7891')
    end
  end

  it "cannot friend a user more than once", :vcr do
    OmniAuth.config.test_mode = true
    user_1 = create(:user)
    user_2 = create(:user, github_handle: 'rer7891')
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
    click_link "Login Through Github"

    within ".github" do
      expect(page).to have_content("Followers")
      within "#follower-rer7891" do
        expect(page).to have_link("rer7891")
        click_link "Add as Friend"
      end
    end

    within ".github" do
      expect(page).to have_content("Followers")
      within "#follower-rer7891" do
        expect(page).not_to have_link("Add as Friend")
      end
    end
  end
end
