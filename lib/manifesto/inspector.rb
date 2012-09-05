require 'fileutils'

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
      FileUtils.cd path do
        `bundle install`
      end
    end

    def find_gem_directory
      bundler_path = `bundle show bundler`
      gem_path = bundler_path.match /(.*)\/bundler/
      gem_path and gem_path[0]
    end

    def find_gems
      self.gem_directory ||= find_gem_directory
      lockfile.rewind
      lockfile.each_line do |line|
        matches = line.match(/^\s{4}([a-z\-_]*) \((.*)\)/i)
        if matches
          self.gems[matches[1]] = {"version" => matches[2]}
        end
      end
    end

    def gem_list
      gems.keys
    end
  end
end
