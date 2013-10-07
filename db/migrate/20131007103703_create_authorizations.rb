class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :organization_id
      t.integer :child_id

      t.timestamps
    end
  end
end
