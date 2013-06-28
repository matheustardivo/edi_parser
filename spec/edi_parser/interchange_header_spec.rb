require "spec_helper"

module EdiParser
  describe InterchangeHeader do
    context "validate all attributes" do
      let(:processing_date_now) { Date.new }
      subject {
        InterchangeHeader.new(
          carrier_name: "Carrier name",
          receiver_name: "Receiver name",
          processing_date: processing_date_now,
          name: "Name"
        )
      }

      its(:carrier_name) { should == "Carrier name" }
      its(:receiver_name) { should == "Receiver name" }
      its(:processing_date) { should == processing_date_now }
      its(:name) { should == "Name" }
    end

    context "parse invalid ocurrence EDI file" do
      let(:line) { File.open("spec/fixtures/OCOR_invalid.txt", &:readline) }

      it "raise InvalidInterchangeHeaderError" do
        expect { InterchangeHeader.parse(line) }.to raise_error(InvalidInterchangeHeaderError)
      end
    end

    context "parse valid ocurrence EDI file" do
      let(:line) { File.open("spec/fixtures/OCOR_valid.txt", &:readline) }

      it "parse the interchange header" do
        interchange_header = InterchangeHeader.parse(line)
        interchange_header.carrier_name.should == "TEX COURIER LTDA"
        interchange_header.receiver_name.should == "WAL MART"
        interchange_header.processing_date.should == DateTime.new(2013, 6, 7, 11, 05)
        interchange_header.name.should == "OCO070611051"
      end
    end
  end
end
