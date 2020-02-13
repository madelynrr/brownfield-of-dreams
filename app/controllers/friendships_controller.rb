class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_handle: params[:name])
    friendship = Friendship.new(user_id: current_user.id, friend_id: friend.id)
    if friendship.save
      redirect_to '/dashboard'
      flash[:notice] = 'Friend Added'
    else
      redirect_to '/dashboard'
      flash[:error] = 'An Error Has Occured'
    end
  end
end
