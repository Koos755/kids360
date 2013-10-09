class Organization < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :children, through: :authorizations

end
