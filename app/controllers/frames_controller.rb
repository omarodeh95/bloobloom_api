class FramesController < ApplicationController

  before_action :set_frame, only: %i[ show update destroy ]

  def index
    json_data = []
    @frames = Frame.all

    @frames.each do |frame|
      json_data.push({frame: frame, frame_prices: frame.frame_prices})
    end

    render json: json_data
  end 

  def show
    json_data = {frame: @frame, frame_prices: @frame.frame_prices}
    render json: json_data
  end

  def create
    @frame = Frame.new(frame_params)
    if @frame.save
      render json: @frame, status: :created, location: @frame
    else
      render json: @frame.errors, status: :unprocessable_entity
    end 
   end 

  def update
    if @frame.update(frame_prices)
      render json: @frame
    else
      render json: @frame.errors, status: :unprocessable_entity
    end 
  end 

  def destroy
    @frame.destroy
  end 

  private
  def set_frame
    @frame = Frame.find(params[:id])
  end 

  def frame_params
    params.require(:frame).permit(:name, :description, :status, :stock)
  end 
end
