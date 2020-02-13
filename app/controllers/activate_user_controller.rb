class ActivateUserController < ApplicationController

  def new
    email = "#{params[:email]}.#{params[:format]}"
    user = User.find_by(email: email)
    user.toggle!(:active)
  end
end
