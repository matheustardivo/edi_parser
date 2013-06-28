require "spec_helper"

module EdiParser
  describe DocumentHeader do
    context "validate all attributes" do
      subject {
        DocumentHeader.new("Document id")
      }

      its(:document_id) { should == "Document id" }
    end

    context "parse invalid ocurrence EDI file" do
      let(:line) { get_line(filename: "OCOR_invalid.txt") }

      it "raise InvalidDocumentHeaderError" do
        expect { DocumentHeader.parse(line) }.to raise_error(InvalidDocumentHeaderError)
      end
    end

    context "parse valid ocurrence EDI file" do
      let(:line) { get_line(filename: "OCOR_valid.txt", line_number: 2) }

      it "parse the document header" do
        document_header = DocumentHeader.parse(line)
        document_header.document_id.should == "OCORR070611053"
      end
    end

    context "parse valid ONTIME ocurrence EDI file" do
      let(:line) { get_line(filename: "OCOR_ONTIME_valid.txt", line_number: 2) }

      it "parse the document header" do
        document_header = DocumentHeader.parse(line)
        document_header.document_id.should == "240520131406OCOR1_ONTIME"
      end
    end
  end
end
