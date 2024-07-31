class AddNameToAuths < ActiveRecord::Migration[7.2]
  def change
    add_column :auths, :name, :string
  end
end
