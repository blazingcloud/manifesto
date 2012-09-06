module Manifesto
  class Reporter
    attr_accessor :gems, :dir

    HEADER = 'This manifest detailing gem license information has been created by the gem Manifesto.'

    def initialize opts
      self.gems = opts[:gems]
      self.dir = opts[:dir] + "/manifestos"
    end

    def print
      Dir.mkdir(dir) unless Dir.exist?(dir)
      File.open "#{dir}/manifest.txt", 'w' do |f|
        f.write(header)
        f.write(body)
      end
    end

    def header
      "#{HEADER}/n/nGenerated at: #{Time.now}\n\n"
    end

    def body
      str = ""
      gems.each do |gem_name, info|
        str << print_gem( gem_name, info )
      end
      str
    end

    def print_gem gem_name, info
      str = "#{gem_name}, version #{info['version']}:\n"
      str << "    #{info['licenses'].size} licenses:\n"
      info['licenses'].each_with_index do |license, i|
        str << "    #{i+1}: #{license['body']}"
      end
      str
    end
  end
end
