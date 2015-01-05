require 'test_helper'

class CommentCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:admin)
    @topic = topics(:one)
  end

  test 'user logs on and posts a comment' do
    log_in_as(@user)
    assert_difference 'Comment.count', 1 do
      post topic_comments_path(@topic, comment: { content: 'Hi!' })
    end
  end

  test 'user logs on and posts invalid comment' do
    log_in_as(@user)
    assert_no_difference 'Comment.count' do
      post topic_comments_path(@topic, comment: { content: '' })
    end
  end
end
