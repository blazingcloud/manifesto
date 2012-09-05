module Manifesto
  class Inspector
    attr_accessor :path, :lockfile, :gem_directory, :gems

    def initialize path
      self.path = path
      raise("Gemfile not found at #{path}") unless File.exist?("#{path}/Gemfile")
      lockpath = "#{path}/Gemfile.lock"
      bundle unless File.exist?(lockpath)
      self.lockfile = File.new("#{path}/Gemfile.lock", 'r')
      self.gems = {}
    end

    def bundle
      Dir.chdir path do
        `bundle install`
      end
    end

    def find_gem_directory
      bundler_path = `bundle show bundler` # a gem that is know to exist!
      bundler_path.gsub /\/bundler.*\n$/, ''
    end

    def find_gems
      lockfile.rewind
      lockfile.each_line do |line|
        matches = line.match(/^\s{4}([a-z\-_]*) \((.*)\)/i)
        if matches
          self.gems[matches[1]] = {
            "version" => matches[2],
            "licenses" => []
          }
        end
      end
      unless gems["bundler"]
        version = `bundle version`
        matches = version.match(/(\d\.\d\.\d)$/)
        gems["bundler"] = {
          "version" => (matches and matches[1]),
          "licenses" => []
        }
      end
    end

    def find_licenses
      self.gem_directory ||= find_gem_directory
      find_gems
      missing_gems = []
      gems.each do |name, info|
        dir = "#{gem_directory}/#{name}-#{info['version']}"
        if File.exist? dir
          licenses = Dir.entries(dir).map do |d| 
            d if d.match(/license|copying|legal|gpl/i)
          end.compact
          
          licenses.each do |file_name|
            body = File.read("#{dir}/#{file_name}")
            gems[name]['licenses'] << {
              'body' => body
            }
          end
        else 
          missing_gems << name
        end
      end

      # do something special to find the missing gems
    end

    def gem_list
      gems.keys
    end
  end
end
