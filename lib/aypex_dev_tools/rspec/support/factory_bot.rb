require "factory_bot"

FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

# enable factories decorators
Dir[Rails.root.join("spec/factories/aypex/**/*.rb")].sort.each do |factory|
  require factory if /decorator/.match?(factory)
end
