class Parent < ActiveRecord::Base
 has_secure_password
 has_many :children

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true

  def confirm
    self.email_confirmed = true
    self.save
  end

end
