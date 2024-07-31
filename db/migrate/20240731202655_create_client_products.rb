class CreateClientProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :client_products, id: false do |t|
      t.string :state, null: false
      t.uuid :prod_id, null: false
      t.float :payout_rate, null: false
      t.uuid :client_id, null: false
      t.uuid :conn_id, primary_key: true

      t.timestamps
    end
  end
end
