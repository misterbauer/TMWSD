require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
  	user = User.first
  	log_in_user(user.id)
    get :show, :id => user.id
    assert_response :success
    log_out_user
  end

  test "should get login" do
  	user = User.first
    get :show, :id => user.id
    assert_redirected_to login_url
  end

end
