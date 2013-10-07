class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.integer :parent_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
