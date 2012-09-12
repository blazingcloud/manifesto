module Manifesto
  class Reporter
    attr_accessor :gems, :dir

    HEADER = 'This manifest detailing gem license information has been created by the gem Manifesto.'

    def initialize opts
      self.gems = opts[:gems]
      self.dir = opts[:dir] + "/manifestos"
    end

    def print
      unless self.class::FORMAT
        raise "Please add a FORMAT constant to the class to generate a report of this type"
      end
      Dir.mkdir(dir) unless Dir.exist?(dir)
      File.delete("#{dir}/manifest.#{self.class::FORMAT}") if File.exist?("#{dir}/manifest.#{self.class::FORMAT}")
      File.open "#{dir}/manifest.#{self.class::FORMAT}", 'w' do |f|
        f.write(full_report)
      end
      full_report
    end

    def full_report
      header + body + exceptions
    end

    def header
      "#{HEADER}\n\nGenerated at: #{Time.now}\n\n"
    end

    def body
      str = ""
      gems.each do |gem_name, info|
        str << print_gem( gem_name, info )
      end
      str
    end

    def exceptional_gems
      error_cases = {}
      gems.each do |gem_name, info|
        if info['licenses'].size == 0
          error_cases[gem_name] = info
        end

        info['licenses'].each do |license|
          if license['type'] == "UNKNOWN"
            error_cases[gem_name] = info
          end
        end
      end
      error_cases
    end

    def exceptions
      # stub method, should be overridden by subclasses
    end

    def print_gem gem_name, info
      # stub method, should be overridden by subclasses
    end

    def self.inherited klass
      @@reporters ||= []
      @@reporters << klass
      @@reporters.uniq
    end

    def self.reporters
      @@reporters
    end

    def self.print opts
      @@reports = []
      reporters.each do |klass|
        begin
          @@reports << klass.new(opts).print
        rescue Exception => e
          puts "Unable to print manifest in format #{klass}:\n#{e}"
        end
      end
      return nil #@@reports
    end
  end
end
