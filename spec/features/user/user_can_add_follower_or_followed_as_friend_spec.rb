require 'rails_helper'

describe "as a user" do
  it "can see a button to friend a follower", :vcr do
    OmniAuth.config.test_mode = true
    user_1 = create(:user)
    user_2 = create(:user, github_handle: "jfangonilo")
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
    click_link("Login Through Github")

    within(first(".followers")) do
      expect(page).to have_link("jfangonilo")
      expect(page).to have_link("Add as Friend")
    end
  end

  it "will not see button for users who do not have github accounts", :vcr do
    OmniAuth.config.test_mode = true
    user_1 = create(:user)
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
    click_link("Login Through Github")

    within(first(".followers")) do
      expect(page).to have_link("jfangonilo")
      expect(page).not_to have_link("Add as Friend")
    end
  end

  it "can see a button to friend someone they are following", :vcr do
    OmniAuth.config.test_mode = true
    user_1 = create(:user)
    user_2 = create(:user, github_handle: "jfangonilo")
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
    click_link("Login Through Github")

    within(first(".following")) do
      expect(page).to have_link("jfangonilo")
      expect(page).to have_link("Add as Friend")
    end
  end

  it "will not see button for users they are following who do not have github accounts", :vcr do
    OmniAuth.config.test_mode = true
    user_1 = create(:user)
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
    click_link("Login Through Github")

    within(first(".following")) do
      expect(page).to have_link("jfangonilo")
      expect(page).not_to have_link("Add as Friend")
    end
  end
end
