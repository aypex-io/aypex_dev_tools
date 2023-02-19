require "database_cleaner-active_record"

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  # Before each spec check if it is a Javascript test and switch
  # between using database transactions or not where necessary.
  config.before(:each, :js) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before do
    DatabaseCleaner.start
    Rails.cache.clear

    create(:country, name: "United States of America", iso_name: "UNITED STATES", iso: "US", states_required: true)
    create(:store, default: true)
  end

  # After each spec clean the database.
  config.append_after do
    DatabaseCleaner.clean
  end
end
