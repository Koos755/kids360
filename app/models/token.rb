require 'securerandom'

class Token < ActiveRecord::Base
  belongs_to :parent

  validates :value, presence: true
  validates :parent_id, presence: true
  validates :token_type, presence: true

  def create_token_value
    self.value = SecureRandom.urlsafe_base64(30)
  end
end
