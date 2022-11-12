class AddFrameRefToFramePrices < ActiveRecord::Migration[7.0]
  def change
    add_reference :frame_prices, :frame, foreign_key: true
  end
end
