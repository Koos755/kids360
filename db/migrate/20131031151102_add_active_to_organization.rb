class AddActiveToOrganization < ActiveRecord::Migration
  def change
    remove_column :organizations, :active
  end
end
