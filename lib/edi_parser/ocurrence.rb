module EdiParser
  class Ocurrence
    attr_accessor :sender_cnpj, :invoice, :code, :date, :incoming_code, :geoposition

    def initialize(attributes = {})
      attributes.each do |key, value|
        __send__("#{key}=", value)
      end
    end

    def self.parse(line)
      return nil unless line.starts_with?("342")

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
