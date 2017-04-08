require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

Dir[File.dirname(__FILE__) + '/tasks/*.rake'].each { |task| import task }

RSpec::Core::RakeTask.new(:spec)

task default: :spec
