require 'rails/generators'
class ManifestoGenerator < Rails::Generators::Base
  source_root File.expand_path('../../templates/', __FILE__)

  def git_hook
    copy_file "pre-commit", ".git/hooks/pre-commit"
  end
end

