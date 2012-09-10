require 'json'
manifesto_dir = File.dirname(__FILE__) + "/manifesto"
require "#{manifesto_dir}/inspector"
require "#{manifesto_dir}/reporter"
require "#{manifesto_dir}/reporter/text"
require "#{manifesto_dir}/reporter/markdown"
require "#{manifesto_dir}/reporter/json"

module Manifesto
  def self.generate dir
    inspector = Inspector.new dir
    inspector.find_licenses
    puts "Generating a manifesto for #{dir}"
    reporter = Reporter.print :gems => inspector.gems, :dir => dir
  end
end

require "#{manifesto_dir}/railtie" if defined?(Rails)
