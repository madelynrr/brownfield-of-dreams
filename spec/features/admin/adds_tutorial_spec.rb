require 'rails_helper'

describe 'An admin user can add tutorials' do
  it 'clicks on the add tag on a tutoral' do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"
    fill_in "tutorial[title]", with: "This title"
    fill_in "tutorial[description]", with: "This description"
    fill_in "tutorial[thumbnail]", with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"
    click_on "Save"

    tutorial = Tutorial.last
    expect(current_path).to eq("/tutorials/#{tutorial.id}")
  end
end
