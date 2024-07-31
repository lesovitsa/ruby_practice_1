class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products, id: false do |t|
      t.string :name, null: false
      t.string :description
      t.string :state, null: false
      t.uuid :product_id, primary_key: true

      t.timestamps
    end
  end
end
