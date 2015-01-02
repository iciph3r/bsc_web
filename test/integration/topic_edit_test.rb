require 'test_helper'

class UserEditsTopicTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:patience)
    @topic = topics(:two)
    @other_topic = topics(:one)
  end

  test 'user is redirected when they try to edit topic before logging in' do
    post topics_path, topic: { title: 'hi' }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'user is redirected when they try to edit someone elses topic' do
    log_in_as(@user)
    patch topic_path(@topic), topic: { title: 'bye' }
    assert_not flash.empty?
    assert_redirected_to topic_comments_path(@topic)
    @topic.reload
    assert_not_equal @topic.title, 'bye'
  end

  test 'user successfully edits topic' do
    log_in_as(@user)
    title = 'bye'
    patch topic_path(@other_topic), topic: { title: title }
    assert_not flash.empty?
    assert_redirected_to topic_comments_path(@other_topic)
    @other_topic.reload
    assert_equal @other_topic.title, title
  end
end
