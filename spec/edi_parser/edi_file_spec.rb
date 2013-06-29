require "spec_helper"

module EdiParser
  describe EdiFile do
    context "validate all attributes" do
      let(:interchange_header) { mock(:interchange_header) }
      let(:document_header) { mock(:document_header) }
      let(:carrier_data) { mock(:carrier_data) }
      let(:ocurrences) {
        [mock(:ocurrence1), mock(:ocurrence2)]
      }

      subject {
        EdiFile.new(
          interchange_header: interchange_header,
          document_header: document_header,
          carrier_data: carrier_data,
          ocurrences: ocurrences
        )
      }

      its(:interchange_header) { should == interchange_header }
      its(:document_header) { should == document_header }
      its(:carrier_data) { should == carrier_data }
      its(:ocurrences) { should == ocurrences }
    end

    context "parse valid ONTIME ocurrence EDI file" do
      subject {
        EdiFile.parse("spec/fixtures/OCOR_ONTIME_valid_2.txt")
      }

      it "have 2 ocurrences" do
        subject.ocurrences.length.should == 2
      end

      it "first ocurrence should be valid" do
        ocurrence = subject.ocurrences.first
        ocurrence.sender_cnpj.should == "14314050000310"
        ocurrence.invoice.should == Invoice.new(number: 122503, series: "49")
        ocurrence.code.should == "01"
        ocurrence.date.should == DateTime.new(2013, 6, 7, 20, 53)
        ocurrence.incoming_code.should == "00"
        ocurrence.geoposition.should == "ENTREGA REALIZADA"
      end
    end

    context "parse valid ONTIME ocurrence EDI file" do
      subject {
        EdiFile.parse("spec/fixtures/OCOR_valid.txt")
      }

      it "have 3288 ocurrences" do
        subject.ocurrences.length.should == 3288
      end

      it "first ocurrence should be valid" do
        ocurrence = subject.ocurrences.first
        ocurrence.sender_cnpj.should == "14314050000310"
        ocurrence.invoice.should == Invoice.new(number: 185659, series: "47")
        ocurrence.code.should == "95"
        ocurrence.date.should == DateTime.new(2013, 6, 7, 9, 19)
        ocurrence.incoming_code.should == ""
        ocurrence.geoposition.should == ""
      end
    end

    context "parse invalid EDI files" do
      it "raise InvalidEdiFileError because EDI file doesn't exists" do
        expect { EdiFile.parse("file_not_exists.txt") }.to raise_error(InvalidEdiFileError)
      end

      it "raise InvalidInterchangeHeaderError because EDI file doesn't have a valid interchange header" do
        expect { EdiFile.parse("spec/fixtures/OCOR_invalid_interchange_header.txt") }.to raise_error(InvalidInterchangeHeaderError)
      end

      it "raise InvalidDocumentHeaderError because EDI file doesn't have a valid document header" do
        expect { EdiFile.parse("spec/fixtures/OCOR_invalid_document_header.txt") }.to raise_error(InvalidDocumentHeaderError)
      end

      it "raise InvalidCarrierDataError because EDI file doesn't have a valid carrier data" do
        expect { EdiFile.parse("spec/fixtures/OCOR_invalid_carrier_data.txt") }.to raise_error(InvalidCarrierDataError)
      end
    end

    context "parse valid EDI file with 2 invalid ocurrences lines" do
      subject {
        EdiFile.parse("spec/fixtures/OCOR_valid_with_invalid_ocurrences.txt")
      }

      it "have 2 ocurrences" do
        subject.ocurrences.length.should == 2
      end
    end
  end
end
