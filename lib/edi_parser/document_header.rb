module EdiParser
  class DocumentHeader
    attr_accessor :document_id

    def initialize(id)
      self.document_id = id
    end

    def self.parse(line)
      raise InvalidDocumentHeaderError, "Line #{line} doesn't begin with 340 header (OCORRENCIA DA NOTA FISCAL)" unless line.start_with?("340")
      DocumentHeader.new(line[3..26].strip)
    end
  end

  class InvalidDocumentHeaderError < StandardError; end
end
