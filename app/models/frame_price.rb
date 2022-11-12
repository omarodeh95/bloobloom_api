class FramePrice < ApplicationRecord
  belongs_to :frame

  validates :id, presence:true
  validates :id, numericality: { only_integer: true }

  validates :price, presence: true
  validates :price,numericality: { only_float: true }

  validates :currency, inclusion: {in: ["USD", "GBP", "EUR", "JOD", "JPY"]}
  validates :currency, uniqueness: {scope: [:frame_id]}

  validates :frame_id, presence: true
end
