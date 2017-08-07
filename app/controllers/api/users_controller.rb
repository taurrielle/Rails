class Api::UsersController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token


  def create
    user = params["user"]
    accounts = params["accounts"]

    u = User.create(email: user["email"], password: user["password"], password_confirmation: user["password_confirmation"])
    accounts.each do |account|
      a = u.accounts.create(name: account["name"], balance: account["balance"], currency: account["currency"])
      account["transactions"].each do |transaction|
        u.transactions.create(ammount: transaction["amount"], description: transaction["description"], made_on_date: transaction["made_on_date"], currency: transaction["currency"], account_id: a.id)
      end
    end
  end

end
