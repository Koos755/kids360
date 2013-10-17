class AddColumnToParent < ActiveRecord::Migration
  def change
    add_column :parents, :terms, :datetime
  end
end
