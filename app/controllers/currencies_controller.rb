class CurrenciesController < ApplicationController
  respond_to :json

  def index
    respond_with Currency.all
  end

end