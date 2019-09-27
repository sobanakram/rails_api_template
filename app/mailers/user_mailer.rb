class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_reset_password_code.subject
  #
  def send_reset_password_code(user)
    @user = user
    mail to: user.email, subject: 'Reset password instructions'
  end
end
