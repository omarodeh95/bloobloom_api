class Glasses
  attr_reader :status
  attr_accessor :frame, :lense, :currency

  def initialize(frame, lense, currency)

    @frame = frame 
    @lense = lense 
    @currency = currency
    @frame.change_currency @currency
    @lense.change_currency @currency
    @status = "design"
    return false unless (@frame.can_make_glasses? && @lense.can_make_glasses?)
  end

  def valid?
    return true if @frame.can_make_glasses? && @lense.can_make_glasses? && (@currency == @frame.currency && @currency == @lense.currency) && @status != "created"
    return false
  end

  def create

    return false if (!self.valid? || @status == "created")
  
    ActiveRecord::Base.transaction do
      if (@frame.remove_from_stock && @lense.remove_from_stock(2))
        @status = "created"
      else
        raise ActiveRecord::Rollback
      end

    rescue ActiveRecord::Rollback
      return false
    end

    return true
  end

  def discard

    return false if (@status != "created")

    ActiveRecord::Base.transaction(requires_new: true) do

      if (@frame.add_to_stock && @lense.add_to_stock(2))
        @status = "design"
      else
        raise ActiveRecord::Rollback
      end

    rescue ActiveRecord::RollBack
      return false
    end

    return true
  end
  def reload_object
    @frame.reload
    @lense.reload
  end
  
end
