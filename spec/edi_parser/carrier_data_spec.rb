require "spec_helper"

module EdiParser
  describe CarrierData do
    context "validate all attributes" do
      subject {
        CarrierData.new(cnpj: "Carrier cnpj", corporate_name: "Corporate name")
      }

      its(:cnpj) { should == "Carrier cnpj" }
      its(:corporate_name) { should == "Corporate name" }
    end

    context "parse invalid ocurrence EDI file" do
      let(:line) { get_line(filename: "OCOR_invalid.txt") }

      it "raise InvalidCarrierDataError" do
        expect { CarrierData.parse(line) }.to raise_error(InvalidCarrierDataError)
      end
    end

    context "parse valid ocurrence EDI file" do
      let(:line) { get_line(filename: "OCOR_valid.txt", line_number: 3) }

      it "parse the carrier data" do
        carrier_data = CarrierData.parse(line)
        carrier_data.cnpj.should == "73939449000193"
        carrier_data.corporate_name.should == "TEX COURIER LTDA"
      end
    end

    context "parse valid ONTIME ocurrence EDI file" do
      let(:line) { get_line(filename: "OCOR_ONTIME_valid.txt", line_number: 3) }

      it "parse the carrier data" do
        carrier_data = CarrierData.parse(line)
        carrier_data.cnpj.should == "09329143000116"
        carrier_data.corporate_name.should == "ONTIME LOGISTISTICA LTDA"
      end
    end
  end
end
