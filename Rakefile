# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'dry-monads-sorbet'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

spec = Gem::Specification.find_by_name 'dry-monads-sorbet'
rakefile = "#{spec.gem_dir}/lib/dry-monads-sorbet/Rakefile"
load rakefile
