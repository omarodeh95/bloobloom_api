class FramesController < ApplicationController
  before_action :authorize_user
  before_action :set_frame, only: %i[ show update destroy ]
  before_action :authorize_admin, only: %i[create update destroy]

  def index
    json_data = []
    if @current_user.type == "admin"
      @frames = Frame.all
    else
      @frames = Frame.where(status:true)
    end

    @frames.each do |frame|
      frame_prices = frame.frame_prices.where(currency: session["currency"])
      json_data.push({frame: frame, frame_prices: frame_prices}) unless frame_prices.empty?
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
      render json: @frame, status: :created
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
    filters = {id: params[:id]}
    if @current_user.type == "Customer"
      filters[:status] = true
    end
    @frame = Frame.find_by(filters)
  end 

  def frame_params
    params.require(:frame).permit(:name, :description, :status, :stock)
  end 
end
