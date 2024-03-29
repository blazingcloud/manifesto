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
        name = name.gsub(/^\d_/, '')
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
      match = nil
      licenses.each do |name, text|
        next if match 
        lev_distance = calculator(text).match(source)
        match_details = [lev_distance, name, text]
        if (1 -lev_distance/source.size.to_f)*100 > 85
          match = match_details
        end
        info << match_details
      end
      match ||= info.min
      Packager.extract match, source
    end

    class Packager
      attr_accessor :type, :percent_matched, :diff, :match, :source
      def initialize match, source
        self.match = match
        self.source = source
      end

      def extract
        calculate_percent_matched
        calculate_diffs
        calculate_type
        {
          'type' => type,
          'percent_matched' => percent_matched,
          'diff' => diff
        }
      end

      def calculate_diffs
        self.diff = if percent_matched > 50 and percent_matched < 100
          source.gsub(match[2], '')
        end
      end

      def calculate_percent_matched
        self.percent_matched = ((1 - match[0]/source.size.to_f)*100).round
      end

      def calculate_type
        self.type = if percent_matched.to_i >= 50
          match[1].gsub('_', ' ').upcase
        else
          'UNKNOWN'
        end
      end

      def self.extract match, source
        packager = new match, source
        packager.extract
      end
    end
  end
end
