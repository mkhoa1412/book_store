source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

## Rails should go at the top—it drives everything
gem 'rails', '~> 6.1.3'

## These gems are managed/provided by rails new
gem 'bootsnap', '>= 1.4.4', require: false
gem 'pg', '~> 1.1'
gem 'puma', '~> 4.1'

## Do Not add the following gems:
# * turbolinks - we want control over how pages perform and Turbolinks is unobservable
# * spring/listen - Spring causes more problems than it solves

## Our gems - keep in alphabetical order and document why each one
##            is included in this project

# Brakeman checks for security vulns in our code
gem 'brakeman'

# bundler-audit enabled bundle audit
# which analyzes our dependencies for
# known vulnerabilities
gem 'bundler-audit'

# Lograge manages Rails' logging so
# it's a bit easier to deal with in prod
gem 'lograge'

# ultimate pagination
gem 'pagy', '~> 3.5'

# serializer
gem 'jsonapi-serializer'

# sidekiq is for background job processing
gem 'sidekiq'

# API operations.
gem 'rswag-api'
gem 'rswag-ui'

# others
gem 'money-rails', '~>1.12'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'json-schema_builder'
  gem 'rspec-rails'
  gem 'rswag-specs'

  # debug
  gem 'byebug'
  gem 'pry-rails'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner-active_record'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
