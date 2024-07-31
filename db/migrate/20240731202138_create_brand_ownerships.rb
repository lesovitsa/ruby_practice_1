class CreateBrandOwnerships < ActiveRecord::Migration[7.2]
  def change
    create_table :brand_ownerships, id: false do |t|
      t.uuid :brand_id, null: false
      t.uuid :product_id, null: false
      t.uuid :conn_id, primary_key: true

      t.timestamps
    end
  end
end
