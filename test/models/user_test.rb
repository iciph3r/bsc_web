require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:patience)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name shold be present' do
    @user.name = '     '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '     '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'name should not be too short' do
    @user.name = 'a'
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 256
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[patience@bsc.com BOB@foo.COM E_ma-il@sub.dom.ain
                         one.name@mail.net extra+char@nzed.nz]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[patience@bsc,net missing_a_sign.org hmm@place.
                           check@om_nom.nom foo@bar+baz.py]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email address should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email addresses should be saved as lower-case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'username should be valid' do
    valid_names = %w[bobby jimmy hark norsu azazello Eaëlo]
    valid_names.each do |valid_name|
      @user.name = valid_name
      assert @user.valid?, "#{valid_name} should be valid."
    end
  end

  test 'username should not accept spaces' do
    @user.name = 'rick bob'
    assert_not @user.valid?
  end

  test 'password should have minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with a nil digest' do
    assert_not @user.authenticated?(:activation, '')
  end
end
