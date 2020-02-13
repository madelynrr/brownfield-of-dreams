class UserActivateMailer < ApplicationMailer

  def inform(user_email)
    @user_email = user_email
    mail(to: user_email, subject: 'Please activate your account.')
  end

  def invite(user, invitee)
    @invitee = invitee
    @user = user
    mail(to: invitee[:email], subject: 'Welcome to Brownfield.')
  end
end
