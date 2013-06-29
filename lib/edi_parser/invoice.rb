module EdiParser
  class Invoice
    attr_accessor :number, :series

    def initialize(attributes = {})
      attributes.each do |key, value|
        __send__("#{key}=", value)
      end
    end

    def ==(another)
      return false unless another.respond_to?(:number) && another.respond_to?(:series)
      number == another.number && series == another.series
    end
  end
end
