ENV["BUNDLE_GEMFILE"] = File.dirname(__FILE__) + "/../../../Gemfile"

require "bundler"
require "rails/all"

Bundler.setup
Bundler.require(:default)

module EdiParser
  class Application < Rails::Application
    config.root = File.dirname(__FILE__) + "/.."
    config.active_support.deprecation = :log
  end
end

EdiParser::Application.initialize!
