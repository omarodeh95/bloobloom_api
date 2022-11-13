class Lense < ApplicationRecord
  has_many :lense_prices

  validates :id, uniqueness: true
  validates :id, numericality: { only_integer: true }

  validates :colour, presence: true
  

  validates :prescription_type, inclusion: {in: ["fashion", "single_vision", "varifocal"]}

  validates :lens_type, inclusion: {in: ["classic", "blue_ligth", "transition"]}

  validates :stock, numericality: { only_integer: true }
  validates :stock, presence: true
  validates :stock, comparison: {greater_than_or_equal_to: 0}

  attr_reader :currency, :price

  def currency=(currency)
    lense_price_info = self.lense_prices.find_by(currency: currency)
    if lense_price_info
      @currency = lense_price_info.currency
      @price = lense_price_info.price
    else
      @currency = nil
      @price = nil
    end
  end

  def can_make_glasses?
    return true if (self.stock > 1 && @currency)
    return false
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
