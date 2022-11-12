class Lense < ApplicationRecord
  has_many :lense_prices

  validates :id, uniqueness: true
  validates :id, presence:true
  validates :id, numericality: { only_integer: true }

  validates :colour, presence: true
  

  validates :prescription_type, inclusion: {in: ["fashion", "single_vision", "varifocal"]}

  validates :lens_type, inclusion: {in: ["classic", "blue_ligth", "transition"]}

  validates :stock, numericality: { only_integer: true }
  validates :stock, presence: true
  validates :stock, comparison: {greater_than_or_equal_to: 0}

  def can_make_glasses?
    return self.stock > 2
  end

  def add_to_stock(quantity = 1)
    self.update!(stock: self.stock + quantity)
  end

  def remove_from_stock(quantity = 1)
    stock = self.stock
    self.stock -= quantity
    if !self.save
      self.stock = stock
      return false
    end
    return true
  end
end
