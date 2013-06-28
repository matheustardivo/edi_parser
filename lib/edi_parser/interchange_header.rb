module EdiParser
  class InterchangeHeader
    attr_accessor :carrier_name, :receiver_name, :processing_date, :name

    def initialize(attributes = {})
      attributes.each do |key, value|
        __send__("#{key}=", value)
      end
    end

    def self.parse(line)
      raise InvalidInterchangeHeaderError, "Line #{line} doesn't begin with 000 header (CABECALHO DE INTERCAMBIO)" unless line.start_with?("000")
    end
  end

  class InvalidInterchangeHeaderError < StandardError; end
end
