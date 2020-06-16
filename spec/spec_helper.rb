# frozen_string_literal: true
# typed: true

require 'bundler/setup'
require 'pry'
require 'rspec'
require 'sorbet-struct-comparable'

ROOT = Pathname(File.expand_path(File.join(File.dirname(__FILE__), '..')))
Dir[ROOT.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
