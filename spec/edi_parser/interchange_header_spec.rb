require "spec_helper"

module EdiParser
  describe InterchangeHeader do
    context "attributes" do
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
  end
end
