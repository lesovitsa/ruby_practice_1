class AddConstraintsAndIndexes < ActiveRecord::Migration[7.2]
  def change
    # brands
    add_index :brands, :brand_id, unique: true
    add_index :brands, :name, unique: true

    # products
    add_index :products, :product_id, unique: true
    add_index :products, :name, unique: true

    # brand_ownerships
    add_index :brand_ownerships, :conn_id, unique: true
    add_foreign_key :brand_ownerships, :brands, column: :brand_id, primary_key: :brand_id
    add_foreign_key :brand_ownerships, :products, column: :product_id, primary_key: :product_id

    # client_products
    add_index :client_products, :conn_id, unique: true
    add_foreign_key :client_products, :auths, column: :client_id, primary_key: :userid
    add_foreign_key :client_products, :brand_ownerships, column: :prod_id, primary_key: :conn_id
  end
end
