require 'manifesto'
require 'rails'
module Manifesto
  class Railtie < Rails::Railtie
    railtie_name :manifesto

    rake_tasks do
      load "tasks/manifesto.rake"
    end
  end
end
