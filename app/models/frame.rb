class Frame < ApplicationRecord

  has_many :frame_prices, dependent: :delete_all

  validates :id, uniqueness: true

  validates :name, presence: true
  

  validates :status, inclusion: [true, false]

  validates :stock, numericality: { only_integer: true }
  validates :stock, presence: true
  validates :stock, comparison: {greater_than_or_equal_to: 0}

  attr_reader :currency

  def can_make_glasses?
    return true if (self.stock > 0 && @currency)
    return false
  end

  def change_currency (currency)
    frame_price_info = self.frame_prices.find_by(currency: currency)
    if frame_price_info
      @currency = frame_price_info.currency
      @price = frame_price_info.price
      return true
    else
      @currency = nil
      @price = nil
      return false
    end
  end

  def add_to_stock(quantity = 1)
    self.update!(stock: self.stock + quantity)
  end

  def remove_from_stock(quantity = 1)
    self.reload
    stock = self.stock
    self.stock -= quantity
    ActiveRecord::Base.transaction(requires_new: true) do
      self.save
      return true
    end
    rescue ActiveRecord::Rollback
      return false
  end
  def self.valid_currencies
    FramePrice.valid_currencies
  end
end
