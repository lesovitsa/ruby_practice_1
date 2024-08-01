class CreateClears < ActiveRecord::Migration[7.2]
  def change
    create_table :clears do |t|
      t.timestamps
    end
  end
end
