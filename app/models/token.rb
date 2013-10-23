require 'securerandom'

class Token < ActiveRecord::Base
  belongs_to :parent

  validates :value, presence: true
  validates :parent_id, presence: true
  validates :token_type, presence: true, inclusion: { in: %w(confirmation password_reset), message: "%{value} is not a valid token_type" }

  after_save :send_email

  def create_confirmation_token(parent)
    self.value = SecureRandom.urlsafe_base64(30)
    self.parent_id = parent.id
    self.token_type = "confirmation"
    self.save
  end

  def create_password_reset_token(parent)
    self.value = SecureRandom.urlsafe_base64(50)
    self.parent_id = parent.id
    self.token_type = "password_reset"
    self.save
  end

  def send_email
    if self.token_type == "confirmation"
      # ParentMailer.delay.confirmation_email(self) #TODO have option without delay
      ParentMailer.confirmation_email(self).deliver #TODO have option without delay
    elsif self.token_type == "password_reset"
      # ParentMailer.delay.password_reset_email(self)
      ParentMailer.password_reset_email(self).deliver
    end
  end

end
