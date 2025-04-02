require 'rails_helper'

RSpec.describe Category do
  it "has a name" do
    category = Category.create!(name: "Malts")
    expect(category.name).to eq("Malts")
  end

  describe "validations" do
    it "is invalid without a name" do
      category = Category.new(name: nil)
      expect(category).to_not be_valid
      expect(category.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a duplicate name" do
      Category.create!(name: "Malts")
      duplicate_category = Category.new(name: "Malts")
      # duplicate_category = Category.new(name: "Hops")

      expect(duplicate_category).to_not be_valid
      expect(duplicate_category.errors[:name]).to include("has already been taken")
    end
  end
end
