require 'rails_helper'

RSpec.describe Category do
  it "has a name" do
    category = Category.create!(name: "Malts")
    expect(category.name).to eq("Malts")
  end
end
