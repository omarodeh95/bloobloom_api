class BasketController < ApplicationController
  before_action :check_and_set_default_currency
  before_action :basket_params

  def add_item
    basket = session["basket"]
    basket ||= []
    frame = Frame.find(@frame_id)
    lense = Lense.find(@lense_id)
    frame.change_currency @currency
    lense.change_currency @currency
    glass = Glasses.new(frame,lense,@currency)
    if glass.valid?
      item = {frame_id: @frame_id, lense_id: @lense_id}
      basket.push(item) 
      session["basket"] = basket
      render json: {item: item, msg: "Item added successfully", status: :ok}
    else
      render json: {msg: "Item Cannot be added to the basket", status: :unprocessable_entity}
    end
  end

  def remove_item
    basket = session["basket"]
    index = params[:item_no].to_i - 1
    if basket.delete_at(index)
      render json: {data: basket, msg: "Item number #{item_no} is removed successfully", status: :ok}
    else
      render json: {data: basket, msg: "Item number #{item_no} is out of range", status: :ok}
    end

  end

  def index
    basket = session["basket"]
    render json: {basket: basket, status: :ok}
  end

  def show
    index = params[:item_no].to_i - 1
    item = session["basket"][index]
    render json: {item: item, msg: "Success", status: :ok}
  end

  def checkout_basket
    errors = []
    basket = session["basket"]
    checked_basket = Basket.new(@currency)
    puts basket.length
    basket.each_with_index do |item,item_no|
      puts item_no
      frame_id = item["frame_id"]
      lense_id = item["lense_id"]
      frame = Frame.find(frame_id)
      lense = Lense.find(lense_id)
      frame.change_currency @currency
      lense.change_currency @currency
      glasses = Glasses.new(frame, lense, @currency)
      if !checked_basket.add(glasses)
        errors.push("#{frame_id} and #{lense_id} for item no #{item_no + 1} cannot be created")
      end
    end

    errors.push("could not checkout basket") if (!checked_basket.checkout_basket || errors.any?)
    if errors.any?
      render json: {errors: errors , msg: "Basket is not checkoued out", status: :unprocessable_entity}
    else
      render json: {basket: checked_basket , msg: "Basket is checkoued out successfully", status: :ok}
    end

  end

  def change_currency
    currency = @currency
    if (Frame.valid_currencies.include?(currency) && Lense.valid_currencies.include?(currency))
      session["currency"] = currency 
      session["basket"] = []
      render json: {msg: "Currency changed to #{currency} successfully", status: :ok}
    else
      render json: {msg: "Currency is not valid", status: :unprocessable_entity}
    end
  end

  def check_and_set_default_currency
    session["currency"] ||= "USD"
  end

  private
  def basket_params
    @currency = request.params[:basket][:currency]
    @frame_id = request.params[:basket][:frame_id]
    @lense_id = request.params[:basket][:lense_id]
  end
end