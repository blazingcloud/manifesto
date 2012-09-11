module Manifesto
  class Inspector
    attr_accessor :path, :lockfile, :gem_directories, :gems

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

    def find_gem_directories
      ENV["GEM_PATH"].split(File::PATH_SEPARATOR)
    end

    def find_gems
      lockfile.rewind
      lockfile.each_line do |line|
        matches = line.match(/^\s{4}([a-z\-_\.]*) \((.*)\)/i)
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
      self.gem_directories ||= find_gem_directories
      find_gems
      missing_gems = []
      gem_directories.each do |gem_directory|
        gems.each do |name, info|
          next if gems[name]['licenses'].size > 0

          dir = "#{gem_directory}/gems/#{name}-#{info['version']}"
          if extract_licenses dir, name
            missing_gems.delete(name)
          else
            missing_gems << name
          end
        end
      end

      missing_gems.uniq.each do |name|
        dir = `bundle show #{name}`.strip
        extract_licenses dir, name
      end
    end

    def gem_list
      gems.keys
    end

    def extract_licenses dir, name
      unless File.exist? dir
        return false
      end

      licenses = Dir.entries(dir).map do |d|
        d if d.match(/license|copying|legal|gpl/i)
      end.compact

      licenses.each do |file_name|
        body = File.read("#{dir}/#{file_name}")
        license_data = {
          'body' => body
        }
        match = MatchMaker.find(body)
        unless match['proximity'] >= match['total_length']
          license_data['type'] = match['type']
          license_data['proximity'] = match['proximity']
          license_data['difference_ratio'] = match['proximity']/match['total_length'].to_f
        end

        gems[name]['licenses'] << license_data
      end
      true
    end
  end
end
