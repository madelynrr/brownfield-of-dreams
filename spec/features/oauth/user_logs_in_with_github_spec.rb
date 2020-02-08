require 'rails_helper'

describe "as a user"
  it "can log in through github oauth" do
    user = create(:user)

    visit '/'

    click_link "Login Through Github"

    fill_in :username, with: user.email
    fill_in



  end
