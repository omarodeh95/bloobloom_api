class Glasses
  attr_reader :frame, :lense, :status

  def frame=(frame)
    @status = "design"
  end

  def lense=(lense)
    @status = "design"
  end

  def initialize(frame, lense)

    raise ArgumentError, "It is not a frame" if !frame.is_a? Frame
    raise ArgumentError, "It is not a lense" if !lense.is_a? Lense
    @frame = frame 
    @lense = lense 
    @status = "design"

  end

  def valid?
    return @frame.stock > 0 && @lense.stock > 1
  end

  def create

    return false if (!self.valid? || @status == "created")

    old_frame_stock = self.frame.stock
    old_lense_stock = self.lense.stock
  
    ActiveRecord::Base.transaction do
      if (@frame.remove_from_stock && @lense.remove_from_stock(2))
        @status = "created"
      else
        puts "making rollback error"
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
  
end
