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

    return 0 if (!self.valid? || @status == "created")

    ActiveRecord::Base.transaction(joinable:false, requires_new: true) do
      @frame.remove_from_stock
      @lense.remove_from_stock(2)
      @status = "created"
    end

    rescue ActiveRecord::RecordInvalid
      return 0

    return 1
  end

  def discard

    return 0 if (@status != "created")

    ActiveRecord::Base.transaction(joinable:false, requires_new: true) do
      @frame.add_to_stock
      @lense.add_to_stock(2)
      @status = "design"
    end

    rescue ActiveRecord::RecordInvalid
      return 0

    self.destroy
    return 1
  end
  
end
