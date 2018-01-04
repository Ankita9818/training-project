class UserMailer < ActionMailer::Base
  def verify_email(user)
    @user = user
    mail(from: Rails.application.secrets.email_id, to: @user.email, subject: 'Registration Confirmation')
  end

  def reset_password(user)
    @user = user
    mail(from: Rails.application.secrets.email_id, to: @user.email, subject: 'Password Reset')
  end
end
