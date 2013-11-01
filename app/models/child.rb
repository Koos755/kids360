class Child < ActiveRecord::Base
  belongs_to :parent
  belongs_to :doctor
  has_many :authorizations, :dependent => :destroy
  has_many :organizations, :through => :authorizations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, inclusion: { in: %w(male female), message: "%{value} is not a valid gender" }

end
