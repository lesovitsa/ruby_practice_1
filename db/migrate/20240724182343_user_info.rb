class UserInfo < ActiveRecord::Migration[7.2]
  def change
    create_table :user_info, id: false do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.uuid :user_id, null: false, primary_key: true
    end

    add_index :user_info, :user_id, using: 'hash'
    add_index :user_info, :email, using: 'hash'
  end
end
