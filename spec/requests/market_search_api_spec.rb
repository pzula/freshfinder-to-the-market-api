require 'spec_helper'

describe "Markets Search API" do
  describe "GET /api/v1/markets/search?zip=80218" do
    it "returns the nearby markets within the default radius" do
      # make a market in Denver (make an address)
      # make a market in Florida (make an address)
      denver_market = FactoryGirl.create :market, :name => "Denver Hipster Hoodlum"
      florida_market = FactoryGirl.create :market, :name => "Boca Bacon Bathers"

      FactoryGirl.create :address, :market_id => denver_market.id,
                                   :zipcode => 80218,
                                   :lat => 39.7392,
                                   :long => -104.9847

      FactoryGirl.create :address, :market_id => florida_market.id,
                                   :zipcode => 33431,
                                   :lat => 26.3686,
                                   :long => -80.1000

      # make a call to the api search

      get "/api/v1/markets/search?zip=80218"
      expect(response.status).to eq 200

      body = JSON.parse(response.body)

      market_names = body.map { |market| market["name"] }

      # assert the denver market is in the results
      expect(market_names).to match_array(["Denver Hipster Hoodlum"])

      # refute the florida market is in the results
      expect(market_names).not_to contain("Boca Bacon Bathers")
    end
  end
end
