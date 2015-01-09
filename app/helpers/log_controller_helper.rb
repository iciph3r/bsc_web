module LogControllerHelper

  def colorize(line)
    line
    #line.gsub(/\*.+\*/, '<span class="enemy">\0</span>')
    #line.gsub(/^[[:alpha:]]+\snarrates\s'.+'$/, '<span class="narrate">\0</span>')
    #line.gsub(/^#.+$/, '<span class="comment">\0</span>')
  end
end
