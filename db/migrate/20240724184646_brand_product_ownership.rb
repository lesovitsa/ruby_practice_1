class BrandProductOwnership < ActiveRecord::Migration[7.2]
  def change
    create_table :brand_product_ownership, id: false do |t|
      t.uuid :brand_id, null: false
      t.uuid :product_id, null: false
      t.uuid :ownership_id, null: false, primary_key: true
    end

    add_foreign_key :brand_product_ownership, :brand_info, column: :brand_id, primary_key: :brand_id
    add_foreign_key :brand_product_ownership, :product_info, column: :product_id, primary_key: :product_id
    add_index :brand_product_ownership, :ownership_id, using: 'hash'
  end
end
