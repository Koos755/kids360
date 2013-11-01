class AddToChildren < ActiveRecord::Migration
  def change
    add_column :children, :dob, :date
    add_column :children, :gender, :string
    add_column :children, :school, :string
  end
end
