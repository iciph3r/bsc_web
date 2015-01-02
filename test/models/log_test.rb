require 'test_helper'

class LogTest < ActiveSupport::TestCase

  test 'user_id must be present' do
    log = Log.new
    log.user_id = ''
    assert_not log.valid?
  end

  test 'path must be present' do
    log = Log.new
    log.path = ''
    assert_not log.valid?
  end

  test 'title must be present and less than 255 characters' do
    log = Log.new
    log.title = ''
    assert_not log.valid?
    log.title = 'a' * 256
    assert_not log.valid?
  end

  test 'description must be present and less than 255 characters' do
    log = Log.new
    log.description = ''
    assert_not log.valid?
    log.description = 'a' * 256
    assert_not log.valid?
  end

  test 'view_count must be present and greater than -1' do
    log = Log.new
    log.view_count = ''
    assert_not log.valid?
    log.view_count = -1
    assert_not log.valid?
  end
end
