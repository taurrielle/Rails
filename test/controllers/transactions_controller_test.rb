require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  def sign_in(user)
    post user_session_path \
      "user[email]"    => user.email,
      "user[password]" => user.password
  end

  def setup
    @user = User.create(
      email:    "example@gmail.com",
      password: Devise::Encryptor.digest(User, "password1")
    )
    sign_in @user
    @account = @user.accounts.create(
      name:     "test",
      balance:  4000,
      currency: "USD"
    )
    @user.transactions.create(
      ammount:      400,
      description:  "test",
      made_on_date: "2017-08-08",
      account_id:   @account.id,
      currency:     "USD"
    )
  end

  test "should create transaction" do
    assert_difference 'Transaction.count' do
      post transactions_path,
      params: {
        transaction: {
          ammount:      400,
          description:  "test",
          made_on_date: "2017-08-08",
          account_id:   @account.id,
          currency:     "USD"
        }
      }
    end
  end

  test "should get only user's transactions" do
    get transactions_path
    transactions = JSON.parse(response.body)
    transactions.each { |transaction| assert_equal transaction["user_id"], @user.id }
  end

end
