# spec/support/database_cleaner.rb

RSpec.configure do |config|
  if Rails.env.test?
    # https://github.com/DatabaseCleaner/database_cleaner#safeguards
    DatabaseCleaner.allow_remote_database_url = true
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
