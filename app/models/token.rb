require 'securerandom'

class Token < ActiveRecord::Base
  belongs_to :parent

  validates :value, presence: true
  validates :parent_id, presence: true
  validates :token_type, presence: true, inclusion: { in: %w(confirmation password_reset), message: "%{value} is not a valid token_type" }

  # after_save :send_email

  def create_confirmation_token(parent)
    self.value = SecureRandom.urlsafe_base64(30)
    self.parent_id = parent.id
    self.token_type = "confirmation"
    self.save
  end

  def send_email
    if self.token_type == "confirmation"
      ParentMailer.confirmation_email(self).deliver
    elsif self.token_type == "password_reset"
      ParentMailer.password_reset_email(self).deliver
    end
  end

end
