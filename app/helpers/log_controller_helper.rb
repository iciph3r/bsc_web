module LogControllerHelper

  def colorize(line)
    line.gsub!(/\*[[:alpha:]]+\s.+[[:alpha:]]\*/, %Q[<span class="enemy">\\0</span>])
    case line
    when /(^[[:alpha:]]+\snarrates\s'.+')(\r\n|\n|\r)/
      %Q[<span class="yellow">#{$1}</span>#{$n}]
    when /(^.+ tells you '.+')(\r\n|\n|\r)/
      %Q[<span class="green">#{$1}</span>#{$n}]
    when /(^.+ (hits|cleaves|smites|pierces|slashes|pounds|crushes|stabs|shoots) your .+)(\r\n|\n|\r)/,
         /(^.+ sends you sprawling .+\.)(\r\n|\n|\r)/,
         /(^You fall, and hit yourself!)(\r\n|\n|\r)/,
         /(^You feel a sharp ache there!)(\r\n|\n|\r)/,
         /(^That really HURT!)(\r\n|\n|\r)/
      %Q[<span class="red">#{$1}</span>#{$n}]
    when /(^.+ says '.+')(\r\n|\n|\r)/,
         /(^You .*(slash|pierce|shoot|hit|pound|crush|smite|cleave|shoot).+)(\r\n|\n|\r)/,
         /(^The lightning bolt hits .+impact\.)(\r\n|\n|\r)/
      %Q[<span class="cyan">#{$1}</span>#{$n}]
    when /(^.+ yells.+'.+')(\r\n|\n|\r)/
      %Q[<span class="magenta">#{$1}</span>#{$n}]
    when /(^(Heath|Brushy Valley|Gentle Slope|Ruins).+)(\r\n|\n|\r)/
      %Q[<span class="green">#{$1}</span>#{$n}]
    else
      line
    end
  end
end
