require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  def sign_in(user)
    post user_session_path \
      "user[email]"    => user.email,
      "user[password]" => user.password
  end

  test "should get home" do
    get root_url
    assert_response :success
  end

  test "should get accounts" do
    @user = User.create(
      email:    "david@gmail.com",
      password: Devise::Encryptor.digest(User, "password1")
    )
    sign_in @user
    get pages_accounts_url
    assert_response :success
  end

  test "should get transactions" do
    @user = User.create(
      email:    "david@gmail.com",
      password: Devise::Encryptor.digest(User, "password1")
    )
    sign_in @user
    get pages_transactions_url
    assert_response :success
  end

  test "user is redirected to sign in page when visiting accounts page" do
     get pages_accounts_url
     assert_redirected_to "/users/sign_in"
   end

  test "user is redirected to sign in page when visiting transactions page" do
    get pages_transactions_url
    assert_redirected_to "/users/sign_in"
  end

  test "user redirected on sign in and sign out" do
    get root_path
    @user = User.create(
      email:    "david@gmail.com",
      password: Devise::Encryptor.digest(User, "password1")
    )
    sign_in @user
    get root_path
    assert_redirected_to pages_accounts_url
    delete destroy_user_session_path
    assert_redirected_to root_path
  end

end