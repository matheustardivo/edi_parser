module EdiParser
  class CarrierData

    # @return [String] the carrier cnpj.
    attr_accessor :cnpj

    # @return [String] the carrier corporate name.
    attr_accessor :corporate_name

    def initialize(attributes = {})
      attributes.each do |key, value|
        __send__("#{key}=", value)
      end
    end

    def self.parse(line)
      raise InvalidCarrierDataError, "Line #{line} doesn't begin with 000 header (DADOS DA TRANSPORTADORA)" unless line.start_with?("341")
      CarrierData.new(cnpj: line[3..16].strip, corporate_name: line[17..56].strip)
    end
  end

  class InvalidCarrierDataError < StandardError; end
end
