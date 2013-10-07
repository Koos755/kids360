class Organization < ActiveRecord::Base
  has_many :authorizations
  has_many :children, through: :authorizations

end
