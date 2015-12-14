# -*- coding: utf-8 -*-

require 'rspec/core/rake_task'

task :default => [:spec]

desc 'Run all test'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

namespace :spec do
  desc 'Run test for addition feature'
  RSpec::Core::RakeTask.new(:addition) do |spec|
    spec.pattern = FileList[ 'spec/features/addition_spec.rb' ]
  end

  desc 'Run test for subtraciton feature'
  RSpec::Core::RakeTask.new(:subtraction) do |spec|
    spec.pattern = FileList[ 'spec/features/subtraction_spec.rb']
  end

  desc 'Run test for multiplication feature'
  RSpec::Core::RakeTask.new(:multiplication) do |spec|
    spec.pattern = FileList[ 'spec/features/multiplication_spec.rb']
  end

  desc 'Run test for division feature'
  RSpec::Core::RakeTask.new(:division) do |spec|
    spec.pattern = FileList[ 'spec/features/division_spec.rb']
  end
end
