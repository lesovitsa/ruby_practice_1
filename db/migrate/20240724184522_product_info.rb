class ProductInfo < ActiveRecord::Migration[7.2]
  def change
    create_table :product_info, id: false do |t|
      t.string :name, null: false
      t.string :state, null: false
      t.uuid :product_id, null: false, primary_key: true
    end

    add_index :product_info, :product_id, using: 'hash'
  end
end
