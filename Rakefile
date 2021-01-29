# require './lib/tasks'

namespace :ci do
  desc "Run CI Smoke Tests"
  task :test do
    require './lib/tasks/ci'
    Tasks::CI.test
  end
end

desc "run 'rake ci' from Jenkins"
task ci: 'ci:test'

task :default => [:ci]
