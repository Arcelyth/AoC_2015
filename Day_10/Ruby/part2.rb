input = "3113322113"
50.times { input.gsub!(/(.)\1*/) { "#{$&.size}#{$1}" } }
puts input.length
