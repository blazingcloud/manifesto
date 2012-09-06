desc "Create license manifests for the gems in the project"
task :manifesto do
  dir = Dir.pwd
  Manifesto.generate dir
end
