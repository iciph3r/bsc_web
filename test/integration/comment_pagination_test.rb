require 'test_helper'

class CommentPaginationTest < ActionDispatch::IntegrationTest

  test 'comment index including pagination' do
    get topic_path(topics(:one))
    assert_template 'topics/show'
    assert_select 'div.pagination'
  end
end
