class TransactionsController < ApplicationController
  respond_to :json

  def index
    respond_with Transaction.all
  end

  def show

  end

  def create

  end

  def destroy

  end

private

  def account_params
    params.require(:account).permit(:name, :balance, :currency_id)
  end

end