require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
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
  end

  test "should create account" do
    assert_difference 'Account.count' do
      post accounts_path,
      params: {
        account: {
          name:     "Lorem ipsum",
          balance:  4000,
          currency: "USD"
        }
      }
    end
  end

  test "should get only user's accounts" do
    get accounts_path
    accounts = JSON.parse(response.body)
    accounts.each { |account| assert_equal account["user_id"], @user.id }
  end

  test "should change account balance" do
    new_balance = 60000
    patch "/api/accounts/" + @account.id.to_s, params: { account: { balance: new_balance } }
    @account.reload
    assert_equal new_balance, @account.balance
  end

end
