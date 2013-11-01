class RemoveDobFromChild < ActiveRecord::Migration
  def change
    remove_column :children, :dob
  end
end
