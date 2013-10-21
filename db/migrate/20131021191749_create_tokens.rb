class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :value
      t.integer :parent_id
      t.string :token_type

      t.timestamps
    end
  end
end
