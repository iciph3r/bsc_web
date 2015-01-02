require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  def setup
    @base_title = 'Black Shadow Clan'
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_select 'title', "#{@base_title}"
  end

  test 'should get about' do
    get :about
    assert_response :success
    assert_select 'title', "About the BSC | #{@base_title}"
  end

  test 'should get contact' do
    get :contact
    assert_response :success
    assert_select 'title', "Contact | #{@base_title}"
  end
end
