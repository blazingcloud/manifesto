desc "Create license manifests for the gems in the project"
task :manifesto do
  Manifesto.generate Dir.pwd
end
