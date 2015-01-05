require 'test_helper'

class CommentPaginationTest < ActionDispatch::IntegrationTest

  test 'comment index including pagination' do
    get topic_comments_path(topics(:one))
    assert_template 'comments/index'
    assert_select 'div.pagination'
  end
end
