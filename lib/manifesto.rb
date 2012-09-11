require 'json'
require 'amatch'
manifesto_dir = File.dirname(__FILE__) + "/manifesto"

require "#{manifesto_dir}/inspector"
require "#{manifesto_dir}/reporter"
require "#{manifesto_dir}/reporter/text"
require "#{manifesto_dir}/reporter/markdown"
require "#{manifesto_dir}/reporter/json"
require "#{manifesto_dir}/match_maker"

module Manifesto
  def self.generate dir
    inspector = Inspector.new dir
    inspector.find_licenses
    puts "Generating a manifesto for #{dir}"
    Reporter.print :gems => inspector.gems, :dir => dir
  end
end

require "#{manifesto_dir}/railtie" if defined?(Rails)
