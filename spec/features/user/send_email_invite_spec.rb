require 'rails_helper'

RSpec.describe "as a user", :vcr do
  it "sends an invite" do
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
  click_on "Send an Invite"

  expect(current_path).to eq('/invite')

  fill_in :github_handle, with: 'DanielEFrampton'
  click_on 'Send Invite'

  expect(current_path).to eq('/dashboard')
  expect(page).to have_content('Successfully sent invite!')


  click_on "Send an Invite"

  expect(current_path).to eq('/invite')

  fill_in :github_handle, with: 'wrenisit'
  click_on 'Send Invite'

  expect(current_path).to eq('/dashboard')
  expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
