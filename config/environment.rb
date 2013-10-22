# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Kids360::Application.initialize!

Rails.application.routes.default_url_options[:host] = 'localhost:3000'

ActionMailer::Base.smtp_settings = {
  :user_name => 'paay',
  :password => '!@#paay$%^',
  :domain => 'paay.co',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
