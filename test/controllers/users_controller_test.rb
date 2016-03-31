require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
  	user = User.first
    get :show, :id => user.id
    assert_response :success
  end

end
