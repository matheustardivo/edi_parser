ENV["RAILS_ENV"] = "test"

require "rails"
require "edi_parser"
require "support/config/boot"
require "rspec/rails"

Rspec.configure do |config|
  config.include Module.new {
    def fixtures
      @fixtures ||= Pathname.new(File.dirname(__FILE__) + "fixtures")
    end
  }
end
