require 'test_helper'

class TopicsPaginationTest < ActionDispatch::IntegrationTest

  test 'topics index including pagination' do
    get topics_path
    assert_template 'topics/index'
    assert_select 'div.pagination'
    #Topic.paginate(page: 1).each do |topic|
    #  assert_select 'a[href=?]', topic_comments_path(topic), text: topic.title
    #end
  end

  test 'Non-BSC user logs in and does not see BSC only topics' do
    log_in_as(users(:non_bsc))
    get topics_path
    assert_select 'i.fa-lock', count: 0
  end

  test 'non-logged-in users do not see BSC topics' do
    get topics_path
    assert_select 'i.fa-lock', count: 0
  end

  test 'BSC users see BSC topics' do
    log_in_as(users(:patience))
    get topics_path
    assert_select 'i.fa-thumb-tack'
  end
end
