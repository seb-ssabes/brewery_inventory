require 'rails_helper'

RSpec.describe Hop do
  describe "self.load_hops_data" do
    it "parses the CSV file and returns an array of hashes" do
      fake_csv = <<~CSV
        Lúpulo,Aroma/Sabor,Alpha,Tipo,Sustitutos
        Cascade,Citrus,5.5,Dual,Centennial, Amarillo
      CSV
      #The <<~ means this is a heredoc string (multi-line) removing the leading whitespace (indentation) from each line

      allow(CSV).to receive(:foreach).and_yield(CSV.parse(fake_csv, headers: true).first)
      #This line tells the test not to read the hops_data.csv file but instead to test it independently using the fake_csv string

      result = Hop.load_hops_data

      expect(result).to be_an(Array)
      expect(result.first[:name]).to eq("Cascade")
      expect(result.first[:aroma]).to eq("Citrus")
    end
  end

  describe "self.find_substitutes_and_type" do
    before do
      allow(Hop).to receive(:load_hops_data).and_return([
        { name: "Cascade", aroma: "Citrus", alpha: "5.5", hop_type: "Dual", substitutes: "Centennial, Amarillo" },
        { name: "Magnum", aroma: "Neutral", alpha: "12", hop_type: nil, substitutes: nil }
      ])
    end

    it "returns formatted substitute and type info for a known hop" do
      result = Hop.find_substitutes_and_type("Cascade")
      expect(result.first).to eq("Cascade → Centennial | Amarillo → Dual")
    end

    it "returns 'No substitutes found' if substitutes are nil" do
      result = Hop.find_substitutes_and_type("Magnum")
      expect(result.first).to include("No substitutes found")
    end

    it "returns 'Unknown hop type' if hop_type is nil" do
      result = Hop.find_substitutes_and_type("Magnum")
      expect(result.first).to include("Unknown hop type")
    end

    it "returns an empty array when no match is found" do
      result = Hop.find_substitutes_and_type("NonExsistent")
      expect(result).to eq([])
    end
  end
end
