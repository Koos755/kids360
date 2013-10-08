class Child < ActiveRecord::Base
  belongs_to :parent
  has_many :authorizations
  has_many :organizations, :through => :authorizations

  validates :first_name, presence: true
  validates :last_name, presence: true
end
