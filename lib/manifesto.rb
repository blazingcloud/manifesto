manifesto_dir = File.dirname(__FILE__) + "/manifesto"
require "#{manifesto_dir}/inspector"
require "#{manifesto_dir}/reporter"

module Manifesto
  def self.generate dir
    inspector = Inspector.new dir
    inspector.find_licenses
    reporter = Reporter.new :gems => inspector.gems, :dir => dir
    puts "Generating a manifesto for #{dir}"
    reporter.print
  end
end

require "#{manifesto_dir}/railtie" if defined?(Rails)
