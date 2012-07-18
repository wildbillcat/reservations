ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require "minitest/autorun"
require "minitest/rails"
require "minitest/rails/capybara"
MiniTest::Rails.override_testunit! #we won't use Unit::Test because Minitest has replaced it

require 'ffaker'
RubyCAS::Filter.fake('testnetid')

#These might not be necessary?
require 'factory_girl_rails'
#FactoryGirl.find_definitions


# Uncomment if you want Capybara in accceptance/integration tests
# require "minitest/rails/capybara"

# Uncomment if you want awesome colorful output
# require "minitest/pride"

class MiniTest::Rails::ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

# Do you want all existing Rails tests to use MiniTest::Rails?
# Comment out the following and either:
# A) Change the require on the existing tests to `require "minitest_helper"`
# B) Require this file's code in test_helper.rb

# MiniTest::Rails.override_testunit!
