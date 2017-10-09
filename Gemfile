source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.0"
gem "bcrypt", "~> 3.1.7"
gem "puma", "~> 3.7"
gem 'bootstrap-sass', '~> 3.3.6'
gem "sass-rails", "~> 5.0"
gem "sqlite3", "~> 1.3.13"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "dotenv-rails", "~> 2.2.1"
gem "jquery-rails", "~> 4.3.1"

group :development, :test do
  gem "binding_of_caller", "~> 0.7.2"
  gem "pry", "~> 0.11.1"
  gem "pry-byebug", "~> 3.5.0"
  gem "rubocop", "~> 0.49"
  gem "rubocop-github", "~> 0.5"
  gem "selenium-webdriver", "~> 3.6.0"
  gem "rspec-rails", "~> 3.6.1"
  gem "better_errors", "~> 2.3.0"
  gem "annotate", "~> 2.7.2"
  gem "simplecov", "~> 0.15.1"
  # We only want this to be automatically required for tests, so we've moved
  # that into rails_helper
  gem "factory_girl_rails", "~> 4.8.0", require: false
  gem "faker", "~> 1.8.4"
  gem "shoulda-matchers", "~> 3.1"
  gem "database_cleaner", "~> 1.6.1"
  gem "rails-controller-testing", "~> 1.0.2"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring", "~> 2.0.2"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
