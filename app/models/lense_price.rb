class LensePrice < ApplicationRecord
  belongs_to :lense

  validates :id, uniqueness: true

  validates :price, presence: true
  validates :price,numericality: { only_float: true }
  validates :price, comparison: {greater_than_or_equal_to: 0}

  validates :currency, inclusion: {in: ["USD", "GBP", "EUR", "JOD", "JPY"]}
  validates :currency, uniqueness: {scope: [:lense_id]}

  validates :lense_id, presence: true
end
