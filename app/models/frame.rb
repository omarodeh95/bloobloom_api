class Frame < ApplicationRecord

  has_many :frame_prices

  validates :id, uniqueness: true
  validates :id, presence:true
  validates :id, numericality: { only_integer: true }

  validates :name, presence: true
  

  validates :status, inclusion: [true, false]

  validates :stock, numericality: { only_integer: true }
  validates :stock, presence: true
  validates :stock, comparison: {greater_than_or_equal_to: 0}

  def can_make_glasses?
    return self.stock > 1
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
