class TransactionsController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def index
    @user = current_user
    respond_with @user.transactions.all
  end

  def show
  end

  def create
    respond_with current_user.transactions.create(transaction_params)
  end

  def destroy

  end

private

  def transaction_params
    params.require(:transaction).permit(:ammount, :description, :made_on_date, :account_id, :currency)
  end

end