class FramePricesController < ApplicationController

  before_action :set_frame
  before_action :set_frame_price, only: %i[ show update destroy ]

  def index
    @frame_prices = FramePrice.where(frame_id: params[:frame_id])
    render json: @frame_prices
  end 

  def show
    render json: @frame_price
  end

  def create
    @frame_price = @frame.frame_prices.build(frame_price_params)
    if @frame_price.save
      render json: @frame_price, status: :created, location: @frame_frame_price
    else
      render json: @frame_price.errors, status: :unprocessable_entity
    end 
   end 

  def update
    if @frame_price.update(frame_price_params)
      render json: @frame_price
    else
      render json: @frame_price.errors, status: :unprocessable_entity
    end 
  end 

  def destroy
    @frame_price.destroy
  end 

  private
  def set_frame_price
    @frame_price = FramePrice.find(params[:id])
  end

  def set_frame
  @frame = Frame.find(params[:frame_id])
  end

  def frame_price_params
    params.require(:frame_price).permit(:currency, :price)
  end
end
