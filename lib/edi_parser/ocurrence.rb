module EdiParser
  class Ocurrence
    attr_accessor :sender_cnpj, :invoice, :code, :date, :incoming_code, :geoposition

    def initialize(attributes = {})
      attributes.each do |key, value|
        __send__("#{key}=", value)
      end
    end
  end
end
