require 'test_helper'

class TopicsControllerTest < ActionController::TestCase

  def setup
    @user = users(:admin)
    @other_user = users(:bsc_user)
    @topic = topics(:one)
  end

  test 'should redirect new when not logged in' do
    get :new
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect create when not logged in' do
    get :create
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect edit when not logged in' do
    get :edit, id: @topic
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect update when not logged in' do
    patch :update, id: @topic, topic: { title: @topic.title }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect edit when logged in as wrong user' do
    log_in_as(@other_user)
    get :edit, id: @topic
    assert_redirected_to topic_path(@topic)
    assert_not flash.empty?
  end

  test 'should redirect update when logged in as wrong user' do
    log_in_as(@other_user)
    patch :update, id: @topic, topic: { title: @topic.title }
    assert_redirected_to topic_path(@topic)
    assert_not flash.empty?
  end

  test 'view count is incremented when user views thread' do
    assert_difference '@topic.view_count', 1 do
      log_in_as @user
      get :show, id: @topic
      @topic.reload
    end
  end

  test 'view count is not incremented when user updates thread' do
    log_in_as(@user)
    assert_no_difference '@topic.view_count' do
      patch :update, id: @topic, topic: { title: 'hi' }
      assert_redirected_to topic_path(@topic)
      get :show, id: @topic
      @topic.reload
    end
  end
end
