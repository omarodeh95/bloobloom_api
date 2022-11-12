class AddLensesRefToLensPrice < ActiveRecord::Migration[7.0]
  def change
    add_reference :lense_prices, :lense, foreign_key: true
  end
end
