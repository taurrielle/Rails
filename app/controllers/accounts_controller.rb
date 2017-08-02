class AccountsController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def index
    @user = current_user
    respond_with @user.accounts.all
  end

  def show
    respond_with Account.find(params[:id])
  end

  def create
    respond_with current_user.accounts.create(account_params)
  end


  def update
    respond_with Account.update(params[:id], params[:account])
  end

  def destroy
    respond_with Account.destroy(params[:id])
  end

private

  def account_params
    params.require(:account).permit(:name, :balance, :currency_id)
  end

end
