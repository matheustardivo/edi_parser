module EdiParser
  class Ocurrence

    # @return [String] the sender's cnpj.
    attr_accessor :sender_cnpj

    # @return [EdiParser::Invoice] the invoice object.
    attr_accessor :invoice

    # @return [String] the ocurrence code.
    attr_accessor :code

    # @return [DateTime] the ocurrence date and time.
    attr_accessor :date

    # @return [String] the ocurrence incoming code.
    attr_accessor :incoming_code

    # @return [String] the ocurrence textual geoposition.
    attr_accessor :geoposition

    def initialize(attributes = {})
      attributes.each do |key, value|
        __send__("#{key}=", value)
      end
    end

    def self.parse(line)
      return nil unless line.start_with?("342")

      ocurrence = Ocurrence.new
      ocurrence.sender_cnpj = line[3..16]
      ocurrence.invoice = Invoice.new(number: line[20..27].to_i, series: line[17..19].strip)
      ocurrence.code = line[28..29]
      ocurrence.date = DateTime.strptime(line[30, 41], "%d%m%Y%H%M")
      ocurrence.incoming_code = line[42..43].strip
      ocurrence.geoposition = line[44..113].strip

      ocurrence
    end
  end
end
