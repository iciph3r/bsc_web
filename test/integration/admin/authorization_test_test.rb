require 'test_helper'

class Admin::AuthorizationTestTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:patience)
    @non_admin = users(:non_admin)
  end

  test 'non admin users can not access admin namespace' do
    get admin_root_url
    assert_not flash.empty?
    assert_redirected_to login_path
    follow_redirect!
    assert_template 'sessions/new'
    log_in_as(@non_admin)
    assert_redirected_to admin_root_url
    follow_redirect!
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'admin users can access admin namespace' do
    get admin_root_url
    assert_not flash.empty?
    assert_redirected_to login_path
    follow_redirect!
    assert_template 'sessions/new'
    log_in_as(@admin)
    assert_redirected_to admin_root_url
  end
end
