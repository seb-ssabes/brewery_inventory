require 'rails_helper'

RSpec.describe Category do
  describe "associations" do
    it "has many items" do
      category = Category.create!(name: "Barley")

      item1 = category.items.create!(
        name: "Barley1",
        quantity: 30,
        price: 2000,
        origin: "Germany"
      )
      item2 = category.items.create!(
        name: "Barley2",
        quantity: 40,
        price: 3000,
        origin: "Australia"
      )

      expect(category.items).to include(item1, item2)
    end

    it "destroys associated items when deleted" do
      category = Category.create!(name: "Malts")
      
      item = category.items.create!(
        name: "Malt1",
        quantity: 50,
        price: 5000,
        origin: "Australia")

      expect { category.destroy }.to change {Item.count}.by(-1)
    end
  end

  describe "validations" do
    it "is valid with a name" do
      category = Category.new(name: "Yeasts")
      expect(category).to be_valid
    end

    it "is invalid without a name" do
      category = Category.new(name: nil)

      expect(category).not_to be_valid
      expect(category.errors[:name]).not_to be_empty
    end

    it "is invalid with a duplicate name" do
      Category.create!(name: "Malts")
      duplicate_category = Category.new(name: "Malts")

      expect(duplicate_category).not_to be_valid
      expect(duplicate_category.errors[:name]).not_to be_empty
    end
  end
end
