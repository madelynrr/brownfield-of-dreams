class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_handle: params[:name])
    friendship = Friendship.new(user_id: current_user.id, friend_id: friend.id)
    if friendship.save
      flash[:notice] = 'Friend Added'
    else
      flash[:error] = 'An Error Has Occured'
    end
    redirect_to '/dashboard'
  end
end
