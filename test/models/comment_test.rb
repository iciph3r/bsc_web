require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test 'content must be present' do
    comment = Comment.new(content: '  ')
    assert_not comment.valid?
  end

  test 'user_id must be present' do
    comment = Comment.new(user_id: '  ')
    assert_not comment.valid?
  end
end
