class Basket
  attr_reader :currency, :items
  
  def initialize(currency, items = [])
    @currency = currency
    @items = items
  end

  def add(item)
    @items << item if item.valid? && item.currency == @currency
  end
  def remove_item_no(item_no)
    @items.delete_at(item_no -1)
  end
  def length
    return items.length
  end
  def return_item_no(item_no)
    return item[item_no]
  end

end

