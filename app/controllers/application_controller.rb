class ApplicationController < ActionController::API
  before_action :check_and_set_default_currency

  include ::ActionController::Cookies

  def encode_token(payload)
    JWT.encode(payload, 'secret key here')
  end

  def decode_token()
    auth_header = request.headers['Authorization']
    if auth_header
        token = auth_header.split(' ')[1]
        begin
          JWT.decode(token, 'secret key here', true, algorithm: "HS256")
        rescue JWT::DecodeError
          nil
        end
    end
  end

  def authorized_user
    decoded_token = decode_token()
    if decoded_token
      user_id = decoded_token[0]["user_id"].to_i
      @current_user = User.find(user_id)
    end
  end

  def authorize_user
    render json: {msg: "You have to login first"}, status: :unauthorized unless authorized_user
  end

  def authorize_admin
    render json: {msg: "You are not authorized to do this action"}, status: :unauthorized unless authorized_user && @current_user.type == "Admin"
  end

  def check_and_set_default_currency
    session["currency"] ||= "USD"
  end
end
