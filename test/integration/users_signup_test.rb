require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'invalid signup information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: '',
                               email: 'user@invalid',
                               password: 'meh',
                               password_confirmation: 'mah' }
    end
    assert_template 'users/new'
    assert_select 'div.errors'
    assert_select 'div.flash'
  end

  test 'valid signup information with account activation' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, user: { name: 'Jimmy',
                               email: 'jim@bobjim.hey',
                               password: 'secret',
                               password_confirmation: 'secret' }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.active?
    log_in_as(user)
    assert_not is_logged_in?
    get edit_account_path('invalid token')
    assert_not is_logged_in?
    get edit_account_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    get edit_account_path(user.activation_token, email: user.email)
    user.reload.active?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
