# Defined in aypex_dev_tools
require "aypex/testing_support/auth_helpers"
require "aypex/testing_support/checkout_helpers"

# Requires factories and other useful helpers defined in aypex_core.
require "aypex/testing_support/authorization_helpers"
require "aypex/testing_support/caching"
require "aypex/testing_support/controller_requests"
require "aypex/testing_support/factories"
require "aypex/testing_support/locale_helpers"
require "aypex/testing_support/order_walkthrough"
require "aypex/testing_support/url_helpers"

# API v2 helpers
if defined?(Aypex::Api)
  require "jsonapi/rspec"
  require "aypex/api/testing_support/v2/base"
  require "aypex/api/testing_support/v2/current_order"
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
  config.include Aypex::TestingSupport::AuthHelpers, type: :feature
  config.include Aypex::TestingSupport::CheckoutHelpers, type: :feature
  config.include Aypex::TestingSupport::ControllerRequests, type: :controller
  config.include Aypex::TestingSupport::LocaleHelpers

  if defined?(Aypex::Api)
    config.include JSONAPI::RSpec, type: :request # required for API v2 request specs
  end

  config.before :each do
    Rails.cache.clear

    create(:store, default: true)
  end
end
