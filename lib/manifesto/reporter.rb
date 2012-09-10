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
      File.open "#{dir}/manifest.#{self.class::FORMAT}", 'w' do |f|
        f.write(full_report)
      end
    end

    def full_report
      header + body
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
      reporters.each do |klass|
        begin
          klass.new(opts).print
        rescue Exception => e
          puts "Unable to print manifest in format #{klass}:\n#{e}"
        end
      end
    end
  end
end
