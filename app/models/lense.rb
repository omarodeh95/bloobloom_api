class Lense < ApplicationRecord
  has_many :lense_prices

  validates :id, presence:true
  validates :id, numericality: { only_integer: true }

  validates :colour, presence: true
  
  validates :description, presence: true

  validates :prescription_type, inclusion: {in: ["fashion", "single_vision", "varifocal"]}

  validates :lens_type, inclusion: {in: ["classic", "blue_ligth", "transition"]}

  validates :stock, numericality: { only_integer: true }
  validates :stock, presence: true
end
