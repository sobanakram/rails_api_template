# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user/send_reset_password_code
  def send_reset_password_code
    user = User.first
    UserMailer.send_reset_password_code(user)
  end

end
