class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products, id: false do |t|
      t.string :name, null: false
      t.string :state, null: false
      t.string :description, null: false
      t.uuid :product_id, null: false, primary_key: true

      t.timestamps
    end

    add_index :products, :product_id, using: 'hash'
  end
end
