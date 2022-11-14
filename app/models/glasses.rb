class Glasses
  attr_reader :frame, :lense, :status, :currency

  def initialize(frame, lense, currency)

    @frame = frame 
    @lense = lense 
    @currency = currency
    @frame.currency = @currency
    @lense.currency = @currency
    raise ArgumentError, "The currency does not match lense currency" unless (@frame.can_make_glasses? && @lense.can_make_glasses?)
    @status = "design"

  rescue ArgumentError
    @currency = nil
  end

  def valid?
    return true if @frame.can_make_glasses? && @lense.can_make_glasses? && @currency && @status != "created"
    return false
  end

  def create

    return false if (!self.valid? || @status == "created")

    old_frame_stock = self.frame.stock
    old_lense_stock = self.lense.stock
  
    ActiveRecord::Base.transaction do
      if (@frame.remove_from_stock && @lense.remove_from_stock(2))
        @status = "created"
      else
        raise ActiveRecord::Rollback
      end

    rescue ActiveRecord::Rollback
      self.frame.stock = old_frame_stock
      self.lense.stock = old_lense_stock
      return false
    end

    return true
  end

  def discard

    return false if (@status != "created")

    ActiveRecord::Base.transaction do

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
  
  def reload
    @frame.reload
    @lense.reload
  end
  
end
