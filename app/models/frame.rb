class Frame < ApplicationRecord

  has_many :frame_prices

  validates :id, uniqueness: true

  validates :name, presence: true
  

  validates :status, inclusion: [true, false]

  validates :stock, numericality: { only_integer: true }
  validates :stock, presence: true
  validates :stock, comparison: {greater_than_or_equal_to: 0}

  attr_reader :currency

  def can_make_glasses?
    return true if (self.stock > 1 && @currency)
    return false
  end

  def currency=(currency)
    frame_price_info = self.frame_prices.find_by(currency: currency)
    if frame_price_info
      @currency = frame_price_info.currency
      @price = frame_price_info.price
    else
      @currency = nil
      @price = nil
    end
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
