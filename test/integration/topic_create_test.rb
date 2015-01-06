require 'test_helper'

class UserPostsTopicTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:admin)
  end

  test 'invalid topic information before login with nested attributes' do
    get new_topic_path
    assert_not flash.empty?
    assert_redirected_to login_url
    log_in_as(@user)
    assert_no_difference 'Topic.count' do
      post topics_path, topic: { title: '', comments_attributes: [{ content: '' }] }
    end
    assert_template 'topics/new'
  end

  test 'valid topic submission with nested attributes' do
    log_in_as(@user)
    get new_topic_path
    assert_template 'topics/new'
    assert_difference 'Topic.count', 1 do
      post topics_path, topic: { title: 'Hi', level: :bsc,
                                 comments_attributes: [{ content: 'Lorem' }] }
    end
    assert_redirected_to topic_path(assigns(:topic))
  end
end
