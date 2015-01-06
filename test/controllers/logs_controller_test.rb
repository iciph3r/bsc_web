require 'test_helper'

class LogsControllerTest < ActionController::TestCase

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should get show' do
    get :show, id: logs(:normal_log)
    assert_response :success
  end
end
