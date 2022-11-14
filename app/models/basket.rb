class Basket
  attr_reader :currency, :items
  
  def initialize(currency, items = [])
    @currency = currency
    @items = items
  end

  def add(item)
    if item.valid? && item.currency == @currency
      @items << item 
      return true
    else
      return false
    end

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

  def checkout_basket
    ActiveRecord::Base.transaction do
      @items.each do |item|
        raise ActiveRecord::Rollback if !item.create
      end
    rescue ActiveRecord::Rollback
      @items.each do |item|
        item.reload
      end
      return false
    end
    return true
  end

end

