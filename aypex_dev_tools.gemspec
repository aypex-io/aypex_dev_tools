lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require "aypex_dev_tools/version"

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = "aypex_dev_tools"
  s.version = AypexDevTools::VERSION
  s.summary = "Aypex Dev Tools"
  s.description = "Aypex Developer Tools"
  s.required_ruby_version = ">= 3.2.0"

  s.author = "Aypex"
  s.email = "info@aypex.io"
  s.homepage = "https://github.com/aypex/aypex_dev_tools"
  s.license = "BSD-3-Clause"

  s.files = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(%r{^spec/fixtures}) }
  s.require_path = "lib"
  s.requirements << "none"

  s.add_dependency "appraisal"
  s.add_dependency "awesome_print"
  s.add_dependency "aypex_core"
  s.add_dependency "capybara"
  s.add_dependency "capybara-screenshot"
  s.add_dependency "database_cleaner"
  s.add_dependency "database_cleaner-active_record"
  s.add_dependency "debug"
  s.add_dependency "erb_lint"
  s.add_dependency "factory_bot"
  s.add_dependency "ffaker"
  s.add_dependency "gem-release"
  s.add_dependency "github_changelog_generator"
  s.add_dependency "i18n-tasks"
  s.add_dependency "jsonapi-rspec"
  s.add_dependency "puma"
  s.add_dependency "propshaft"
  s.add_dependency "redis"
  s.add_dependency "rspec-activemodel-mocks"
  s.add_dependency "rspec_junit_formatter"
  s.add_dependency "rspec-rails"
  s.add_dependency "rspec-retry"
  s.add_dependency "rubocop"
  s.add_dependency "rubocop-rails"
  s.add_dependency "rubocop-rspec"
  s.add_dependency "sass-rails"
  s.add_dependency "solargraph"
  s.add_dependency "selenium-webdriver"
  s.add_dependency "simplecov"
  s.add_dependency "standard", "~> 1.0"
  s.add_dependency "timecop"
  s.add_dependency "webdrivers"
  s.add_dependency "webmock"
end