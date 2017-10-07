# frozen_string_literal: true

#Conditionally enable simplecov
if ENV["COVERAGE"] || ENV["COV"]
  require "simplecov"
  SimpleCov.start "rails" do
    coverage_dir "tmp/coverage"

    add_filter "/spec/"
    add_filter "/config/"

    SimpleCov.minimum_coverage 85
    SimpleCov.minimum_coverage_by_file 85
  end
end

ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)

require "rspec/rails"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
# Prevent database truncation if the environment is production
abort("Running in production mode!") if Rails.env.production?

require "spec_helper"

# Add additional requires below this line. Rails is not loaded until this point!

require "factory_girl_rails"
require "database_cleaner"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before :suite do
    require Rails.root.join("spec/data/seeds.rb")
  end

  config.after :suite do
    DatabaseCleaner.clean_with(:truncation)
  end

  # include FactoryGirl
  config.include FactoryGirl::Syntax::Methods
end
