require 'rubygems'
Gem.post_install_hooks << lambda do |inst|
  require 'manifesto'
  Manifesto.generate Dir.pwd
end
