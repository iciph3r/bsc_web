class UserMailer < ActionMailer::Base
  default from: 'noreply@blackshadowclan.com'

  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'BSC: Account Activation'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'BSC: Password Reset'
  end
end
