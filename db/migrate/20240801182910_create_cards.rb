class CreateCards < ActiveRecord::Migration[7.2]
  def change
    create_table :cards, id: false do |t|
      t.uuid :card_id, primary_key: true
      t.string :card_number, null: false
      t.uuid :client_id, null: false
      t.string :activation_number, null: false
      t.string :pin
      t.uuid :prod_id, null: false

      t.timestamps
    end

    add_index :cards, :card_id, unique: true
    add_index :cards, :card_number, unique: true
    add_index :cards, :activation_number, unique: true
    add_foreign_key :cards, :auths, column: :client_id, primary_key: :userid
    add_foreign_key :cards, :brand_ownerships, column: :prod_id, primary_key: :conn_id
  end
end
