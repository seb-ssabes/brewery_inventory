require 'rails_helper'

RSpec.describe Item do
  describe "associations" do
    it "belongs to Category" do
      category = Category.create!(name: "Hop")
      item = Item.create!(name: "Cascade", quantity: 30, price: 2000, origin: "USA",
                          alpha: "5.5", category: category)

    expect(item.category).to eq(category)
    end
  end
end
