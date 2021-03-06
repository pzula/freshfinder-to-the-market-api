require 'spec_helper'

describe "Markets API" do
  describe "GET /api/v1/markets" do
    it "returns all the markets" do
      market = FactoryGirl.create :market
      FactoryGirl.create :address, :market_id => market.id

      get "/api/v1/markets", {}, {"Accept" => "application/json"}

      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      market_names = body.map {|market| market["name"]}
      market_keys = body.first.keys.include?("address")

      expect(market_names).to match_array(["The Fictional Market"])
      expect(market_keys).to be_false
    end
  end

  describe "GET /api/v1/markets?address=true" do
    it "returns addresses for all the markets" do
      market = FactoryGirl.create :market
      FactoryGirl.create :address, :market_id => market.id

      get "/api/v1/markets?address=true", {}, {"Accept" => "application/json"}

      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      market_address = body.map { |market| market["address"]["lat"]}
      expect(market_address).to match_array(["41.073104"])
    end
  end


  describe "GET /api/v1/markets/:market_id/products" do
    it "returns products for the given market" do
      market = FactoryGirl.create :market
      product = FactoryGirl.create :product
      offering = FactoryGirl.create :offering, :market_id => market.id, :product_id => product.id

      get "/api/v1/markets/#{market.id}/products", {}, {"Accept" => "application/json"}

      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      market_products = body.map { |product| product}
      expect(market_products).to match_array(["honey"])
    end
  end

  describe "GET /api/v1/markets/:market_id/payment_types" do
    it "returns accepted payment types for the given market" do
      market = FactoryGirl.create :market
      payment_type = FactoryGirl.create :payment_type
      accepted_payment = FactoryGirl.create :accepted_payment,
                                            :market_id => market.id, :payment_type => payment_type

      get "/api/v1/markets/#{market.id}/payment_types", {}, {"Accept" => "application/json"}

      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      market_payment_types = body.map { |payment_type| payment_type }
      expect(market_payment_types).to match_array(["credit"])
    end
  end

  describe "GET /api/v1/markets/:market_id/schedules" do
    it "returns schedule information for the given market" do
      market = FactoryGirl.create :market
      season = FactoryGirl.create :season, :market_id => market.id
      schedule = FactoryGirl.create :schedule, :season_id => season.id

      get "/api/v1/markets/#{market.id}/schedules", {}, {"Accept" => "application/json"}

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      seasons = body["seasons"]

      expect(seasons[0]["season_number"]).to eq(season.season_number)

      schedules = seasons[0]["schedules"][0]
      expect(schedules["start_time"]).to eq(schedule.start_time)

    end
  end

end
