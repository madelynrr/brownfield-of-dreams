class ActivateUserController < ApplicationController

  def update
    email = "#{params[:email]}.#{params[:format]}"
    user = User.find_by(email: email)
    user.toggle!(:active)
  end

  def new; end

  def create
    user = current_user
    service = GithubService.new
    invitee = service.find_user(user, params[:github_handle])
    if invitee[:email]
      @invitee = invitee
      UserActivateMailer.invite(user, @invitee).deliver_now
      flash[:notice] = "Successfully sent invite!"
      redirect_to '/dashboard'
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
      redirect_to '/dashboard'
    end
  end
end