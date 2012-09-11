module Manifesto
  class MatchMaker
    def self.normalize stream
      str = ""
      stream.each_line do |line|
        str << line.strip.gsub(/\s+/, ' ')
        str << " " # separate each line with a space
      end
      str.strip
    end
  end
end
