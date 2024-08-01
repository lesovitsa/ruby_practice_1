class CreateLogs < ActiveRecord::Migration[7.2]
  def change

    create_table :logs, id: false do |t|
      t.uuid :log_id, primary_key: true
      t.uuid :user_id, null: true # for the purpose of loggine failed registration
      t.string :action, null: false
      t.uuid :client_id, null: true
      t.uuid :brand_id, null: true
      t.uuid :product_id, null: true
      t.uuid :card_id, null: true

      t.timestamps
    end

    add_index :logs, :log_id, unique: true
    add_index :logs, :user_id, unique: false
    add_index :logs, :client_id, unique: false
    add_index :logs, :brand_id, unique: false
    add_index :logs, :product_id, unique: false
    add_foreign_key :logs, :auths, column: :user_id, primary_key: :userid
    add_foreign_key :logs, :auths, column: :client_id, primary_key: :userid
    add_foreign_key :logs, :brands, column: :brand_id, primary_key: :brand_id
    add_foreign_key :logs, :products, column: :product_id, primary_key: :product_id
    add_foreign_key :logs, :cards, column: :card_id, primary_key: :card_id
  end
end
