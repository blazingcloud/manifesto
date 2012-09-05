# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "manifesto"
  gem.homepage = "http://github.com/baccigalupi/manifesto"
  gem.license = "MIT"
  gem.summary = %Q{Manifesto: Providing Visibility into Your Gem Licences}
  gem.description = %Q{Manifesto inspects your bundled gems to compile a list of licences for each gem and sub-gem used in a project. Just use a Gemfile, and Manifesto, and go!}
  gem.email = "info@blazingcloud.net"
  gem.authors = ["Kane Baccigalupi"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
