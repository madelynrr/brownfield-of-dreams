class NotificationsController < ApplicationController

  def create
    UserActivate.inform(current_user.email).deliver_now
  end

end
