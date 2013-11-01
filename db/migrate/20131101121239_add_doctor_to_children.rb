class AddDoctorToChildren < ActiveRecord::Migration
  def change
    add_column :children, :doctor_id, :integer
  end
end
