module EdiParser
  class EdiFile

    # @return [EdiParser::InterchangeHeader] the parsed interchange header object.
    attr_accessor :interchange_header

    # @return [EdiParser::DocumentHeader] the parsed document header object.
    attr_accessor :document_header

    # @return [EdiParser::CarrierData] the parsed carrier data object.
    attr_accessor :carrier_data

    # @return [Array<EdiParser::Ocurrence>] the array of parse ocurrences object.
    attr_accessor :ocurrences

    def initialize(attributes = {})
      attributes.each do |key, value|
        __send__("#{key}=", value)
      end
    end

    def self.parse(file)
      raise InvalidEdiFileError unless File.exists?(file)

      edi_file = EdiFile.new

      File.open(file) do |f|
        edi_file.interchange_header = InterchangeHeader.parse(f.readline)
        edi_file.document_header = DocumentHeader.parse(f.readline)
        edi_file.carrier_data = CarrierData.parse(f.readline)

        edi_file.ocurrences = []
        f.readlines.each do |line|
          ocurrence = Ocurrence.parse(line)
          edi_file.ocurrences << ocurrence unless ocurrence.nil?
        end
      end

      edi_file
    end
  end

  class InvalidEdiFileError < StandardError; end
end
