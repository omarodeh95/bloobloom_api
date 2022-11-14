class FramePrice < ApplicationRecord
  belongs_to :frame

  validates :id, uniqueness: true

  validates :price, presence: true
  validates :price,numericality: { only_float: true }
  validates :price, comparison: {greater_than_or_equal_to: 0}

  validates :currency, inclusion: {in: :valid_currencies}
  validates :currency, uniqueness: {scope: [:frame_id]}

  validates :frame_id, presence: true

  
  def self.valid_currencies
      ["USD", "GBP", "EUR", "JOD", "JPY"]
  end
  def valid_currencies
    FramePrice.valid_currencies
  end

end
