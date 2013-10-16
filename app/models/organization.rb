class Organization < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :children, through: :authorizations

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
