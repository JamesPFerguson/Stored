class CreateContainers < ActiveRecord::Migration[5.1]
  def change
    create_table :containers do |t|
      t.string :name
      t.integer :room_id
    end
  end
end
