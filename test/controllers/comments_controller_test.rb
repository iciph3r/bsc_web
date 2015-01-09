require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  def setup
    @user = users(:bsc_user)
    @topic = topics(:one)
    @comment = comments(:one)
  end

  test 'redirected on create if not logged in' do
    post :create, topic_id: @topic, comment: { content: 'test' }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'redirected on edit if not logged in' do
    get :edit, topic_id: @topic, id: @comment
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'redirected on update if not logged in' do
    patch :update, topic_id: @topic, id: @comment
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'redirected on update if wrong user' do
    log_in_as(@user)
    patch :update, topic_id: @topic, id: @comment
    assert_not flash.empty?
    assert_redirected_to @topic
  end

  test 'redirected on edit if wrong user' do
    log_in_as(@user)
    patch :update, topic_id: @topic, id: @comment
    assert_not flash.empty?
    assert_redirected_to @topic
  end

  test 'should not post comment to non-visible topic' do
    log_in_as(users(:user))
    assert_no_difference 'Comment.count' do
      post :create, topic_id: @topic, comment: { content: 'hi!' }
    end
  end
end
