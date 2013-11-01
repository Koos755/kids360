class Doctor < ActiveRecord::Base
   has_many :children

   validates :name, presence: true
   validates :phone, presence: true

end
