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
  end
end
