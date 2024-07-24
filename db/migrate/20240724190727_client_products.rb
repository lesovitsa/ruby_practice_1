class ClientProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :client_products, id: false do |t|
      t.uuid :client_id, null: false
      t.uuid :brand_product_id, null: false
      t.string :state, null: false
      t.numeric :payout_rate, null: false
      t.uuid :ownership_id, null: false, primary_key: true
    end

    add_foreign_key :client_products, :brand_product_ownership, column: :brand_product_id, primary_key: :ownership_id
    add_foreign_key :client_products, :user_info, column: :client_id, primary_key: :user_id
    add_index  :client_products, :ownership_id, using: 'hash'
  end
end
