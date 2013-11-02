class Doctor < ActiveRecord::Base
   has_many :children

   validates :name, presence: true
   validates :phone, presence: true

   before_destroy :delete_child_foreign_key

   def delete_child_foreign_key
     children = Child.where(doctor_id: self.id)
     children.each do |child|
        child.doctor_id = nil
        child.save
     end
   end
end
