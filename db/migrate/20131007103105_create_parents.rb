class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.boolean :email_confirmed
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :password_digest

      t.timestamps
    end
  end
end
