class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def index
    #render json: {msg: "You are not allowed to access users"}, status: :unauthorized if @user.type == "customer"
    @users = User.all
    render json: @users
  end 

  def show
    #if @user.type == "customer" && @user.id != params[:user_id]
    #  render json: {msg: "You are not allowed to access users"}, status: :unauthorized
    #else
    #end
    render json: @user
  end 

  def create
      users = User.all
      if users.empty?
        @user = Admin.new(user_params)
      else
        @user = Customer.new(user_params)
      end

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end 
  end 

  def update
    #render json: {msg: "You are not allowed to access users"}, status: :unauthorized if @user.type == "customer"
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end 
  end 

  def destroy
    #same validation here 
    @user.destroy
  end 

  private
  def set_user
    @user = User.find(params[:id])
    params.except(:type) if @user.type == "customer"
  end 

  def user_params
    params.require(:user).permit(:user_name, :password_digest, :type)
  end 
end

