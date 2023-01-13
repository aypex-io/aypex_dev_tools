# Required testing support from aypex_core
require "testing_support/authorization_helpers"
require "testing_support/caching"
require "testing_support/controller_requests"
require "testing_support/factories"
require "testing_support/image_helpers"
require "testing_support/i18n" if ENV["CHECK_TRANSLATIONS"]
require "testing_support/locale_helpers"
require "testing_support/order_walkthrough"
require "testing_support/url_helpers"
require "testing_support/capybara_config"

require "aypex/controller_helpers/strong_parameters"

# API v2 helpers
if defined?(Aypex::Api)
  require "jsonapi/rspec"
  require "aypex/api/testing_support/v2/base"
  require "aypex/api/testing_support/v2/current_order"
  require "aypex/api/testing_support/factories"
end

RSpec.configure do |config|
  # Infer an example group's spec type from the file location.
  config.infer_spec_type_from_file_location!

  # == URL Helpers
  #
  # Allows access to Aypex's routes in specs:
  #
  # visit aypex.admin_path
  # current_path.should eql(aypex.products_path)
  config.include Aypex::TestingSupport::UrlHelpers

  # == Requests support
  #
  # Adds convenient methods to request Aypex's controllers
  config.include Aypex::TestingSupport::ControllerRequests, type: :controller
  config.include Aypex::TestingSupport::ImageHelpers
  config.include Aypex::TestingSupport::LocaleHelpers

  config.include Aypex::ControllerHelpers::StrongParameters, type: :controller

  if defined?(Aypex::Api)
    config.include JSONAPI::RSpec, type: :request # required for API v2 request specs
  end

  config.before :suite do
     Capybara.match = :smart
     DatabaseCleaner.clean_with :truncation

     # Force jobs to be executed in a synchronous way
     ActiveJob::Base.queue_adapter = :inline
   end
end
