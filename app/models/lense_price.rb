class LensePrice < ApplicationRecord
  belongs_to :lense

  validates :id, uniqueness: true
  validates :id, presence:true
  validates :id, numericality: { only_integer: true }

  validates :price, presence: true
  validates :price,numericality: { only_float: true }

  validates :currency, inclusion: {in: ["USD", "GBP", "EUR", "JOD", "JPY"]}
  validates :currency, uniqueness: {scope: [:lense_id]}

  validates :lense_id, presence: true
end
