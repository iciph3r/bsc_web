require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  def setup
    @user = users(:impatience)
    @topic = topics(:one)
  end

  test 'redirected on create if not logged in' do
    post :create, topic_id: 1, comment: { content: 'Test' }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'redirected on update if not logged in' do
    patch :update, topic_id: 1, id: 1
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'redirected on update if wrong user' do
    log_in_as(@user)
    patch :update, topic_id: 1, id: 1
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'view count is incremented when someone views a thread' do
    assert_difference '@topic.view_count', 1 do
      get :index, topic_id: @topic
      @topic.reload
    end
  end
end
