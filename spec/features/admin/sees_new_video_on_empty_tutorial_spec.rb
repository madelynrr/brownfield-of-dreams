require 'rails_helper'

describe 'An admin user can edit tutorials', :vcr do
  it 'sees edit on empty tutorial' do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/tutorials/#{tutorial.id}"
  end

  it 'sees tutorial index if empty tutorial' do
    user = create(:user)
    tutorial = create(:tutorial)

    tutorial2 = create(:tutorial)
    video2 = create(:video, tutorial_id: tutorial2.id)

    tutorial3 = create(:tutorial)
    video3 = create(:video, tutorial_id: tutorial3.id)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/tutorials/#{tutorial.id}"
    expect(current_path).to eq('/tutorials')
    expect(page).to have_content('This tutorial is still in progress.')
  end
end
