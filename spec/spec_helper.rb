

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app/makers_bnb.rb')

require 'capybara'
require 'capybara/rspec'
require 'rspec'
require './app/models/space.rb'
require './app/models/user.rb'
require 'database_cleaner'
require 'web_helper'
require 'session'



Capybara.app = MakersBnB

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include SessionHelpers
  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
