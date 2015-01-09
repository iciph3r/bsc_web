module LogControllerHelper

  def colorize(line)
    line.gsub!(/\*[[:alpha:]].+[[:alpha:]]\*/, '<span class="enemy">\0</span>')
    case line
    when /(^[[:alpha:]]+\snarrates\s'.+'$\n)/
      %Q[<span class="yellow">#{$1}</span>]
    when /(^.+\stells\syou\s'.+'$\n)/
      %Q[<span class="green">#{$1}</span>]
    when /(^.+\s(hits|cleaves|smites)\syou.+$\n)/
      %Q[<span class="red">#{$1}</span>]
    when /(^.+\ssays\s'.+'$\n)/, /(^You\s(hit|pound)\s.+$\n)/
      %Q[<span class="cyan">#{$1}</span>]
    when /(^.+\syells.+'.+'$\n)/
      %Q[<span class="magenta">#{$1}</span>]
    else
      line
    end
  end
end
