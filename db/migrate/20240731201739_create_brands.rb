class CreateBrands < ActiveRecord::Migration[7.2]
  def change
    create_table :brands, id: false do |t|
      t.string :name, null: false
      t.string :state, null: false
      t.uuid :brand_id, primary_key: true

      t.timestamps
    end
  end
end
