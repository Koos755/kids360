class AddToChildrenAsDateTime < ActiveRecord::Migration
  def change
    add_column :children, :dob, :datetime
  end
end
