class CreateLensePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :lense_prices do |t|
      t.float :price
      t.string :currency

      t.timestamps
    end
  end
end
