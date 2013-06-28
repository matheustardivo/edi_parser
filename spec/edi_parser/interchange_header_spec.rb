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
      let(:line) { get_line(filename: "OCOR_invalid.txt") }

      it "raise InvalidInterchangeHeaderError" do
        expect { InterchangeHeader.parse(line) }.to raise_error(InvalidInterchangeHeaderError)
      end
    end

    context "parse valid ocurrence EDI file" do
      let(:line) { get_line(filename: "OCOR_valid.txt") }

      it "parse the interchange header" do
        interchange_header = InterchangeHeader.parse(line)
        interchange_header.carrier_name.should == "TEX COURIER LTDA"
        interchange_header.receiver_name.should == "WAL MART"
        interchange_header.processing_date.should == DateTime.new(2013, 6, 7, 11, 5)
        interchange_header.name.should == "OCO070611051"
      end
    end

    context "parse valid ONTIME ocurrence EDI file" do
      let(:line) { get_line(filename: "OCOR_ONTIME_valid.txt") }

      it "parse the interchange header" do
        interchange_header = InterchangeHeader.parse(line)
        interchange_header.carrier_name.should == "ONTIME LOGISTISTICA LTDA"
        interchange_header.receiver_name.should == "WMSSUPERMERCADOS DO BRASIL LTDA"
        interchange_header.processing_date.should == DateTime.new(2013, 5, 24, 14, 6)
        interchange_header.name.should == "OCOR1_ONTIME"
      end
    end
  end
end
