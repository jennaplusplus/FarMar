require "spec_helper"
describe FarMar do
  describe FarMar::Market do

    describe "#initialize" do
      before :each do
        market_info = CSV.open("./support/markets.csv", 'r') { |csv| csv.first }
        @market = FarMar::Market.new(market_info)
      end
      it "creates a new instance of the Market class" do
        expect(@market).to be_an_instance_of(FarMar::Market)
      end
      it "retrieves the market ID from the market info array" do
        expect(@market.id).to eq(1)
      end
    end

    describe ".all" do
      before :each do
        @markets = CSV.read("./support/markets.csv")
      end
      it "returns an array" do
        expect(FarMar::Market.all).to be_an(Array)
      end
      it "returns an array with all the markets" do
        expect(FarMar::Market.all.length).to eq(@markets.size)
      end
      it "contains instances of the Market class" do
        market_total = FarMar::Market.all.length
        expect(FarMar::Market.all[0]).to be_an_instance_of(FarMar::Market)
        expect(FarMar::Market.all[market_total - 1]).to be_an_instance_of(FarMar::Market)
        expect(FarMar::Market.all[market_total]).to be nil
      end

      describe ".find(id)" do
        before :each do
          @id = rand(1..500)
        end
        it "returns an instance of Market" do
          expect(FarMar::Market.find(@id)).to be_an_instance_of(FarMar::Market)
        end
        it "returns the Market with the matching id" do
          expect(FarMar::Market.find(@id).id).to eq(@id)
        end
      end

      describe "#vendors" do
        before :each do
          market_info = CSV.open("./support/markets.csv", 'r') { |csv| csv.first }
          @market = FarMar::Market.new(market_info)
        end
        it "returns a collection" do
          expect(@market.vendors).to be_an(Array)
        end
        it "returns instances of Vendors" do
          expect(@market.vendors[0]).to be_an_instance_of(FarMar::Vendor) if @market.vendors.length > 0
        end
      end
    end

  end
end
