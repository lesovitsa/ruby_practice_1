class AddUseridToAuths < ActiveRecord::Migration[7.2]
  def change
    add_column :auths, :userid, :uuid
  end
end
