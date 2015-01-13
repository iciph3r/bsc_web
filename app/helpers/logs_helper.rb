module LogsHelper

  def colorize(line)
      line.gsub!(/\*[[:alpha:]]+\s.+[[:alpha:]]\*/, %q[<span class="enemy">\0</span>])
      case line
      when /(?<main>^.+ narrates '.+')(?<eol>\r\n|\n|\r)/
        %Q[<span class="yellow">#{$~[:main]}</span>#{$~[:eol]}]
      when /(?<main>^.+ tells you '.+')(?<eol>\r\n|\n|\r)/
        %Q[<span class="green">#{$~[:main]}</span>#{$~[:eol]}]
      when /(?<main>^.+ (hits|cleaves|smites|pierces|slashes|pounds|crushes|stabs|shoots) your .+\.)(?<eol>\r\n|\n|\r)/,
           /(?<main>^.+ sends you sprawling .+\.)(?<eol>\r\n|\n|\r)/,
           /(?<main>^You fall, and hit yourself!)(?<eol>\r\n|\n|\r)/,
           /(?<main>^You feel a sharp (ache|pain) there!)(?<eol>\r\n|\n|\r)/,
           /(?<main>^That really HURT!)(?<eol>\r\n|\n|\r)/,
           /(?<main>^You are wracked with overwhelming PAIN!)(?<eol>\r\n|\n|\r)/,
           /(?<main>^The supernatural flames scorch your flesh with a deathly cold fire!)(?<eol>\r\n|\n|\r)/,
           /(?<main>^You get a shock as .+ grasps at you\.)(?<eol>\r\n|\n|\r)/,
           /(?<main>^.+ sends a powerful lightning bolt at you, you stagger from the impact.)(?<eol>\r\n|\n|\r)/
        %Q[<span class="red">#{$~[:main]}</span>#{$~[:eol]}]
      when /(?<main>^.+ says '.+')(?<eol>\r\n|\n|\r)/,
           /(?<main>^You (\w+ |)(slash|pierce|shoot|hit|pound|crush|smite|cleave|shoot) .+\.)(?<eol>\r\n|\n|\r)/,
           /(?<main>^The lightning bolt hits .+impact\.)(?<eol>\r\n|\n|\r)/,
           /(?<main>^The impact of your lightning bolt kills .+\.)(?<eol>\r\n|\n|\r)/,
           /(?<main>^Your fireball completely envelops .+ in flames\.)(?<eol>\r\n|\n|\r)/
        %Q[<span class="cyan">#{$~[:main]}</span>#{$~[:eol]}]
      when /(?<main>^.+ yells.+'.+')(?<eol>\r\n|\n|\r)/
        %Q[<span class="magenta">#{$~[:main]}</span>#{$~[:eol]}]
      when /(?<main>^(Heath|Brushy Valley|Gentle Slope|Ruins))(?<eol>\r\n|\n|\r)/
        %Q[<span class="green">(#{$~[:main]}</span>#{$~[:eol]}]
      else
        line
      end
  end
end
