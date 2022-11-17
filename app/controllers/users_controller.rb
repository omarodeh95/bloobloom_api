class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :authorize_user, only: %i[ show update destroy ]
  before_action :authorize_admin, only: %i[index]

  def index
    @users = User.all
    render json: @users
  end 

  def show
    if @current_user.id == @user.id || @current_user.type == "Admin"
      render json: @user 
    else
      render json: {msg: "You are not authorized to do this action"}, status: :unauthorized 
    end
  end 

  def create
      users = User.all
      if users.empty?
        @user = Admin.new(user_params)
      else
        @user = Customer.new(user_params)
      end
    
    if @user.save
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}, status: :created 
    else
      render json: @user.errors, status: :unprocessable_entity
    end 
  end 

  def update
    if @current_user.id == @user.id || @current_user.type == "Admin"
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end 
    else
      render json: {msg: "You are not authorized to do this action"}, status: :unauthorized 
    end
  end 

  def destroy
    if @current_user.id == @user.id || @current_user.type == "Admin"
      @user.destroy
    else
      render json: {msg: "You are not authorized to do this action"}, status: :unauthorized 
    end
  end 

  def login
    @user = User.find_by(user_name: user_params[:user_name])
    if @user&.authenticate(user_params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token} ,status: :ok
    else
      render json: {errors: "Invalid username or password"}, status: :unprocessable_entity 
    end
  end
  private
  def set_user
    @user = User.find(params[:id])
    params[:user].delete :type if @user.type == "Customer"
  end 

  def user_params
    params.require(:user).permit(:user_name, :password, :type)
  end 
end

