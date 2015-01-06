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

  test 'should redirect non-logged-in user on new' do
    get :new
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect non-logged-in user on create' do
    post :create, log: logs(:normal_log)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirected non-logged-in users on edit' do
    get :edit, id: logs(:normal_log)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect wrong user on edit' do
    log_in_as(users(:bsc_user))
    get :edit, id: logs(:normal_log)
    assert_not flash.empty?
    assert_redirected_to log_path(logs(:normal_log))
  end

  test 'should redirect non-logged-in users on update' do
    patch :update, id: logs(:normal_log)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect wrong user on update' do
    log_in_as(users(:bsc_user))
    patch :update, id: logs(:normal_log)
    assert_not flash.empty?
    assert_redirected_to log_path(logs(:normal_log))
  end
end
