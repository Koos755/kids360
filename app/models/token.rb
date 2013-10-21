require 'securerandom'

class Token < ActiveRecord::Base
  belongs_to :parent

  validates :value, presence: true
  validates :parent_id, presence: true
  validates :token_type, presence: true, inclusion: { in: %w(confirmation password_reset), message: "%{value} is not a valid token_type" }

  def create_token_value
    self.value = SecureRandom.urlsafe_base64(30)
  end
end