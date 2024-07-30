class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users, id: false do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.uuid :user_id, null: false, primary_key: true

      t.timestamps
    end

    add_index :users, :user_id, using: 'hash'
    add_index :users, :email, using: 'hash'
  end
end
