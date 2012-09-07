STDERR.puts 'got in the install hook file in lib directory'
require 'rubygems'
Gem.post_install_hooks << lambda do |inst|
  STDERR.puts 'inside the actual hook method in lib'  
  require 'manifesto'
  Manifesto.generate Dir.pwd
end
