class LensesController < ApplicationController
  before_action :authorize_user
  before_action :set_lense, only: %i[ show update destroy ]
  before_action :authorize_admin, only: %i[create update destroy]

  def index
    json_data = []

    @lenses = Lense.all
    @lenses.each do |lense|
      lense_prices = lense.lense_prices.where(currency: session["currency"])
      json_data.push({lense: lense, lense_prices: lense_prices}) unless lense_prices.empty?
    end

    render json: json_data
  end 

  def show
    lense_prices = @lense.lense_prices.where(currency: session["currency"])
    json_data = {lense: @lense, lense_prices: lense_prices}
    render json: json_data
  end

  def create
    @lense = Lense.new(lense_params)
    if @lense.save
      render json: @lense, status: :created
    else
      render json: @lense.errors, status: :unprocessable_entity
    end 
   end 

  def update
    if @lense.update(lense_params)
      render json: @lense
    else
      render json: @lense.errors, status: :unprocessable_entity
    end 
  end 

  def destroy
    @lense.destroy
  end 

  private
  def set_lense
    filters = {id: params[:id]}
    @lense = Lense.find_by(filters)
  end 

  def lense_params
    params.require(:lense).permit(:colour, :description, :prescription_type, :lens_type, :stock)
  end 
end
