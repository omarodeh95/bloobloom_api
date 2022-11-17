class Lense < ApplicationRecord
  has_many :lense_prices, dependent: :delete_all

  validates :id, uniqueness: true

  validates :colour, presence: true
  

  validates :prescription_type, inclusion: {in: ["fashion", "single_vision", "varifocal"]}

  validates :lens_type, inclusion: {in: ["classic", "blue_light", "transition"]}

  validates :stock, numericality: { only_integer: true }
  validates :stock, presence: true
  validates :stock, comparison: {greater_than_or_equal_to: 0}

  attr_reader :currency, :price

  def change_currency (currency)
    lense_price_info = self.lense_prices.find_by(currency: currency)
    if lense_price_info
      @currency = lense_price_info.currency
      @price = lense_price_info.price
      return true
    else
      @currency = nil
      @price = nil
      return false
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
    self.reload
    stock = self.stock
    self.stock -= quantity
    self.save
end
  def self.valid_currencies
    LensePrice.valid_currencies
  end
end
