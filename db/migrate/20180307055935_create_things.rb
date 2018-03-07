class CreateThings < ActiveRecord::Migration[5.1]
  def change
    create_table :things do |t|
      t.string :name
      t.string :notes
      t.integer :container_id
    end
  end
end
