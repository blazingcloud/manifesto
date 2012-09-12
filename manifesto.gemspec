# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "manifesto"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kane Baccigalupi"]
  s.date = "2012-09-12"
  s.description = "Manifesto inspects your bundled gems to compile a list of licences for each gem and sub-gem used in a project. Just use a Gemfile, and Manifesto, and go!"
  s.email = "info@blazingcloud.net"
  s.executables = ["manifesto"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/manifesto",
    "lib/comparators/apache_2.txt",
    "lib/comparators/bsd.txt",
    "lib/comparators/gpl_2.txt",
    "lib/comparators/gpl_3.txt",
    "lib/comparators/lgpl_2.txt",
    "lib/comparators/lgpl_3.txt",
    "lib/comparators/mit.txt",
    "lib/comparators/ruby.txt",
    "lib/generators/USAGE",
    "lib/generators/manifesto/git_hook_generator.rb",
    "lib/generators/templates/pre-commit",
    "lib/manifesto.rb",
    "lib/manifesto/inspector.rb",
    "lib/manifesto/match_maker.rb",
    "lib/manifesto/railtie.rb",
    "lib/manifesto/reporter.rb",
    "lib/manifesto/reporter/json.rb",
    "lib/manifesto/reporter/markdown.rb",
    "lib/manifesto/reporter/summary.rb",
    "lib/manifesto/reporter/text.rb",
    "lib/tasks/manifesto.rake",
    "manifesto.gemspec",
    "spec/fixtures/Gemfile",
    "spec/inspector_spec.rb",
    "spec/manifesto_spec.rb",
    "spec/match_maker_spec.rb",
    "spec/reporter_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/blazingcloud/manifesto"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Manifesto: Providing Visibility into Your Gem Licences"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<amatch>, ["~> 0.2.10"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.7"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.2.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<wheel.js>, [">= 0"])
      s.add_development_dependency(%q<gemlicense>, [">= 0"])
      s.add_development_dependency(%q<manifesto>, [">= 0"])
    else
      s.add_dependency(%q<amatch>, ["~> 0.2.10"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<yard>, ["~> 0.7"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.2.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<wheel.js>, [">= 0"])
      s.add_dependency(%q<gemlicense>, [">= 0"])
      s.add_dependency(%q<manifesto>, [">= 0"])
    end
  else
    s.add_dependency(%q<amatch>, ["~> 0.2.10"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<yard>, ["~> 0.7"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.2.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<wheel.js>, [">= 0"])
    s.add_dependency(%q<gemlicense>, [">= 0"])
    s.add_dependency(%q<manifesto>, [">= 0"])
  end
end

