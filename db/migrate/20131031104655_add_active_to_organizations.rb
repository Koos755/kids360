class AddActiveToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :active, :boolean, default: false
  end
end
