class BrandInfo < ActiveRecord::Migration[7.2]
  def change
    create_table :brand_info, id: false do |t|
      t.string :name, null: false
      t.string :state, null: false
      t.uuid :brand_id, null: false, primary_key: true
    end

    add_index :brand_info, :brand_id, using: 'hash'
  end
end
