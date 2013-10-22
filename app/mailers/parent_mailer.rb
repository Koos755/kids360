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

  def no_account_email(email)
    mail(to: email, subject: "No account associated with this email")
  end

  def contact_form_email(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(from: 'contact@kids360now.com', to: 'team@kids360now.com', cc: @email, subject: "Contact form from Kids360")
  end
end
