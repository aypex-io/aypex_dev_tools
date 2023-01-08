# Required testing support from aypex_core
require "aypex/testing_support/authorization_helpers"
require "aypex/testing_support/caching"
require "aypex/testing_support/controller_requests"
require "aypex/testing_support/factories"
require "aypex/testing_support/image_helpers"
require "aypex/testing_support/locale_helpers"
require "aypex/testing_support/order_walkthrough"
require "aypex/testing_support/url_helpers"
require "aypex/testing_support/capybara_config"

require "aypex/core/controller_helpers/strong_parameters"

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

  config.include Aypex::Core::ControllerHelpers::StrongParameters, type: :controller

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
