class Frame < ApplicationRecord

  has_many :frame_prices

  validates :id, presence:true
  validates :id, numericality: { only_integer: true }

  validates :name, presence: true
  
  validates :description, presence: true

  validates :status, inclusion: [true, false]

  validates :stock, numericality: { only_integer: true }
  validates :stock, presence: true
end
