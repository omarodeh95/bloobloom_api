class CreateFrames < ActiveRecord::Migration[7.0]
  def change
    create_table :frames do |t|
      t.string :name
      t.text :description
      t.boolean :status
      t.integer :stock

      t.timestamps
    end
  end
end
