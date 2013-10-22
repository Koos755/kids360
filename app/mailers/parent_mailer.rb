class ParentMailer < ActionMailer::Base
  # default from: "team@kids360now.com"
  default from: 'team@kids360now.com'

  def confirmation_email(token)
    @parent = token.parent
    @url = token_url(token.value)
    mail(to: @parent.email, subject: "Welcome - Please confirm your registration")
  end

  def password_reset_email(token)
    @parent = token.parent
    @url = token_url(token.value)
    mail(to: @parent.email, subject: "Resetting your Kids360 password")
  end
end
