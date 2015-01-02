require 'test_helper'

class TopicTest < ActiveSupport::TestCase

  def setup
    @topic = topics(:one)
  end

  test 'should be valid' do
    assert @topic.valid?
  end

  test 'title should be present' do
    @topic.title = ''
    assert_not @topic.valid?
  end

  test 'title should not be too long' do
    @topic.title = 'a' * 256
    assert_not @topic.valid?
  end

  test 'should not save without user_id' do
    @topic.user_id = ''
    assert_not @topic.valid?
    assert_not @topic.save
  end

  test 'view count should be present' do
    @topic.view_count = ' '
    assert_not @topic.valid?
    assert_not @topic.save
  end

  test 'decrement view should reduce view_count' do
    @topic.view_count = 5
    @topic.decrement_view
    @topic.reload
    assert_equal @topic.view_count, 4
  end

  test 'increment view should increase view_count' do
    @topic.view_count = 5
    @topic.increment_view
    @topic.reload
    assert_equal @topic.view_count, 6
  end

  test 'hide and show should change hidden attribute' do
    @topic.hidden = false
    @topic.reload
    assert_not @topic.hidden?
    @topic.hide!
    @topic.reload
    assert @topic.hidden?
    @topic.show!
    assert_not @topic.hidden?
  end

  test 'show should change hidden attribute' do
  end

  test 'view count should not be less than zero' do
    @topic.view_count = -1
    assert_not @topic.valid?
  end
end
