class LensesPricesController < ApplicationController

  before_action :set_lense
  before_action :set_lense_price, only: %i[ show update destroy ]

  def index
    @lense_prices = LensePrice.where(lense_id: params[:lense_id])
    render json: @lense_prices
  end 

  def show
    render json: @lense_price
  end

  def create
    @lense_price = @lense.lense_prices.build(lense_price_params)
    if @lense_price.save
      render json: @lense_price, status: :created, location: @lense_lense_price
    else
      render json: @lense_price.errors, status: :unprocessable_entity
    end 
   end 

  def update
    if @lense_price.update(lense_price_params)
      render json: @lense_price
    else
      render json: @lense_price.errors, status: :unprocessable_entity
    end 
  end 

  def destroy
    @lense_price.destroy
  end 

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_lense_price
    @lense_price = LensePrice.find(params[:id])
  end

  def set_lense
  @lense = Lense.find(params[:lense_id])
  end

  def lense_price_params
    params.require(:lense_price).permit(:currency, :price)
  end
end
