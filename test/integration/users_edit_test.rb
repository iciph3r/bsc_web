require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:admin)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name: '',
                                    email: 'invalid',
                                    password: 'bar',
                                    password_confirmation: 'meh' }
    assert_template 'users/edit'
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    #name = 'Foobs'
    email = 'email@email.com'
    patch user_path(@user), user: { #name: name,
                                    email: email,
                                    password: '',
                                    password_confirmation: '' }
  assert_not flash.empty?
  assert_redirected_to @user
  @user.reload
  #assert_equal @user.name, name
  assert_equal @user.email, email
  end

  test 'do not allow users to edit names' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Bob'
    patch user_path(@user), user: { name: name,
                                    email: @user.email,
                                    password: '',
                                    password_confirmation: '' }
    @user.reload
    assert_not_equal @user.name, name
    #assert_template 'users/edit'
  end
end
