puts 'got in the install hook file in manifesto directory'
require 'rubygems'
Gem.post_install_hooks << lambda do |inst|
  puts 'inside the actual hook method in manifesto'
  require 'manifesto'
  Manifesto.generate Dir.pwd
end
