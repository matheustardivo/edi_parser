require "coveralls"
Coveralls.wear!

require "bundler"

Bundler.setup(:default, :development)
Bundler.require

require "edi_parser"

Rspec.configure do |config|
  config.include Module.new {
    def fixtures
      @fixtures ||= Pathname.new(File.dirname(__FILE__) + "fixtures")
    end

    def get_line(options = {})
      file = "spec/fixtures/#{options[:filename]}"
      return File.open(file, &:readline) unless options[:line_number] || options[:line_number] == 1

      File.open(file) do |f|
        tmp = nil
        options[:line_number].times { tmp = f.readline }
        tmp
      end
    end
  }
end
