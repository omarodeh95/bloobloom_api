class CurrencyController < ApplicationController
  before_action :currency_params
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
  def currency_params
    @currency = request.params[:currency][:currency_name]
  end
end
