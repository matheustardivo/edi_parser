require "spec_helper"

module EdiParser
  describe Ocurrence do
    context "validate all attributes" do
      let(:date_now) { DateTime.now }
      let(:invoice) { mock(:invoice, number: 9989, series: "1A") }

      subject {
        Ocurrence.new(
          sender_cnpj: "Sender cnpj",
          invoice: Invoice.new(number: 9989, series: "1A"),
          code: "Code",
          date: date_now,
          incoming_code: "Incoming code",
          geoposition: "Geoposition"
        )
      }

      its(:sender_cnpj) { should == "Sender cnpj" }
      its(:invoice) { should == invoice }
      its(:code) { should == "Code" }
      its(:date) { should == date_now }
      its(:incoming_code) { should == "Incoming code" }
      its(:geoposition) { should == "Geoposition" }
    end

    context "parse invalid ocurrence EDI file" do
      let(:line) { get_line(filename: "OCOR_invalid.txt") }

      it "return nil" do
        Ocurrence.parse(line).should be_nil
      end
    end

    context "parse valid ocurrence EDI file" do
      let(:line) { get_line(filename: "OCOR_valid.txt", line_number: 4) }

      it "parse the ocurrence from EDI file in the line 4" do
        ocurrence = Ocurrence.parse(line)
        ocurrence.sender_cnpj.should == "14314050000310"
        ocurrence.invoice.should == Invoice.new(number: 185659, series: "47")
        ocurrence.code.should == "95"
        ocurrence.date.should == DateTime.new(2013, 6, 7, 9, 19)
        ocurrence.incoming_code.should == ""
        ocurrence.geoposition.should == ""
      end
    end

    context "parse valid ONTIME ocurrence EDI file" do
      let(:line) { get_line(filename: "OCOR_ONTIME_valid_2.txt", line_number: 4) }

      it "parse the carrier data" do
        ocurrence = Ocurrence.parse(line)
        ocurrence.sender_cnpj.should == "14314050000310"
        ocurrence.invoice.should == Invoice.new(number: 122503, series: "49")
        ocurrence.code.should == "01"
        ocurrence.date.should == DateTime.new(2013, 6, 7, 20, 53)
        ocurrence.incoming_code.should == "00"
        ocurrence.geoposition.should == "ENTREGA REALIZADA"
      end
    end
  end
end
