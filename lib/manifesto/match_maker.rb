module Manifesto
  module MatchMaker
    COMPARATORS_DIR = File.dirname(__FILE__) + "/../comparators"
    def self.normalize stream
      str = ""
      stream.each_line do |line|
        str << line.strip.gsub(/\s+/, ' ')
        str << " " # separate each line with a space
      end
      str.gsub(/\s+/, ' ').strip
    end

    def self.load_licenses
      return licenses unless licenses.empty?
      Dir.entries(COMPARATORS_DIR).each do |file|
        next if ['.', '..'].include?(file)
        name = File.basename(file, '.txt')
        licenses[name] = normalize(File.read("#{COMPARATORS_DIR}/#{file}"))
      end
      licenses
    end

    def self.licenses
      @licenses ||= {}
    end

    def self.calculator match_string
      Amatch::Levenshtein.new match_string
    end

    def self.find source
      source = normalize(source)
      load_licenses
      info = []
      licenses.each do |name, text|
        info << [calculator(text).match(source), name, text]
      end
      match = info.min

      percent_matched = if match[0]
        ((1 - match[0]/source.size.to_f)*100).round
      end

      if percent_matched.to_i >= 50
        type = match[1].gsub('_', ' ').upcase
      else
        type = 'UNKNOWN'
      end

      diff = if percent_matched > 50 and percent_matched < 100
        source.gsub(match[2], '')
      end

      {
        'type' => type,
        'percent_matched' => percent_matched,
        'diff' => diff
      }    
    end
  end
end
