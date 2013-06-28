module EdiParser
  class InterchangeHeader
    attr_accessor :carrier_name, :receiver_name, :processing_date, :name

    def initialize(attributes = {})
      attributes.each do |key, value|
        __send__("#{key}=", value)
      end
    end
  end
end
