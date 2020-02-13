class UserActivateMailer < ApplicationMailer

  def inform(user_email)
    mail(to: user_email, subject: "Please activate your account.")
  end

end
