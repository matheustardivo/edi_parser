module EdiParser
  class InterchangeHeader

    # @return [String] the carrier name.
    attr_accessor :carrier_name

    # @return [String] the receiver name.
    attr_accessor :receiver_name

    # @return [DateTime] the processing date and time.
    attr_accessor :processing_date

    # @return [String] interchange header name.
    attr_accessor :name

    def initialize(attributes = {})
      attributes.each do |key, value|
        __send__("#{key}=", value)
      end
    end

    def self.parse(line)
      raise InvalidInterchangeHeaderError, "Line #{line} doesn't begin with 000 header (CABECALHO DE INTERCAMBIO)" unless line.start_with?("000")

      header = InterchangeHeader.new

      header.carrier_name = line[3..37].strip
      header.receiver_name = line[38..72].strip

      processing_date_range = 73..82
      name_range = 83..94
      date_time_format = "%d%m%y%H%M"

      if header.carrier_name.start_with?("ONTIME")
        processing_date_range = 73..84
        name_range = 85..96
        date_time_format = "%d%m%Y%H%M"
      end

      header.processing_date = DateTime.strptime(line[processing_date_range], date_time_format)
      header.name = line[name_range].strip

      header
    end
  end

  class InvalidInterchangeHeaderError < StandardError; end
end
