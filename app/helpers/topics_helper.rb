module TopicsHelper
  def topic_level(topic)
    case Topic.levels[topic.level]
    when 0
      'Public'
    when 1
      'Private'
    when 2
      'BSC Only'
    when 3
      'Admin Only'
    end
  end
end
