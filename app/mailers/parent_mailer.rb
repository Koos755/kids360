class ParentMailer < ActionMailer::Base
  default from: "team@kids360now.com"

  def confirmation_email(parent)
    @parent = parent
    @url = parent_url(parent)
    mail(to: @parent.email, subject: "Welcome - Please confirm your registration")
  end
end
