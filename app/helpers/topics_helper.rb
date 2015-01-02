module TopicsHelper
  def bsc_only(boolean)
    '[BSC]' if boolean
  end

  def hidden(boolean)
    '[Hidden]' if boolean
  end
end
