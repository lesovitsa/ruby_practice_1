class CreateBrandProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :brand_products, id: false do |t|
      t.uuid :brand_id, null: false
      t.uuid :product_id, null: false
      t.uuid :connection_id, null: false, primary_key: true

      t.timestamps
    end

    add_foreign_key :brand_products, :brands, column: :brand_id, primary_key: :brand_id
    add_foreign_key :brand_products, :products, column: :product_id, primary_key: :product_id
    add_index :brand_products, :connection_id, using: 'hash'
  end
end
