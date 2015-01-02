require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:patience)
  end

  test 'should get pages' do
    log_in_as(@user)
    get :index
    assert_response :success
  end
end
