class LensesController < ApplicationController

  before_action :set_lense, only: %i[ show update destroy ]

  def index
    json_data = []
    @lenses = Lense.all

    @lenses.each do |lense|
      json_data.push({lense: lense, lense_prices: lense.lense_prices})
    end

    render json: json_data
  end 

  def show
    json_data = {lense: @lense, lense_prices: @lense.lense_prices}
    render json: json_data
  end

  def create
    @lense = Lense.new(lense_params)
    if @lense.save
      render json: @lense, status: :created, location: @lense
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
  # Use callbacks to share common setup or constraints between actions.
  def set_lense
    @lense = Lense.find(params[:id])
  end 

  # Only allow a list of trusted parameters through.
  def lense_params
    params.require(:lense).permit(:colour, :description, :prescription_type, :lens_type, :stock)
  end 
end
