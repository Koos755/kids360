class Child < ActiveRecord::Base
  belongs_to :parent
  has_many :authorizations
  has_many :organizations, :through => :authorizations
end
