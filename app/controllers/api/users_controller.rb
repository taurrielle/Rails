class Api::UsersController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def create
    user_param     = params['user']
    accounts_param = params['accounts']

    user = User.create(
      email:                 user_param['email'],
      password:              user_param['password'],
      password_confirmation: user_param['password_confirmation']
    )
    accounts_param.each do |account|
      accnt = user.accounts.create(
        name:     account['name'],
        balance:  account['balance'],
        currency: account['currency']
      )
      account['transactions'].each do |transaction|
        user.transactions.create(
          ammount:      transaction['amount'],
          description:  transaction['description'],
          made_on_date: transaction['made_on_date'],
          currency:     transaction['currency'],
          account_id:   accnt.id
        )
      end
    end
  end
end
