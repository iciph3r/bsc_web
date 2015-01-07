module TopicsHelper
  def topic_level(topic)
    case Topic.levels[topic.level]
    when 0
      'Public Discussions'
    when 1
      'BN Only Discussions'
    when 2
      'BSC Only Discussions'
    when 3
      'Admin Only Discussions'
    end
  end
end
