class AddIndexToAuth < ActiveRecord::Migration[7.2]
  def change
    add_index :auths, :userid, unique: true
    add_index :auths, :email, unique: true
    change_column_null :auths, :userid, false
    change_column_null :auths, :email, false
  end
end
