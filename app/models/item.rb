class Item < ApplicationRecord
  belongs_to :category

  validates :name, :quantity, :price, :origin, :supplier, presence: true

  validates :alpha, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 25,
    message: "Alpha acids range between 1 and 22"
  }, if: :hop_category?

  validates :potential, presence: true, numericality: {
    greater_than_or_equal_to: 1000,
    less_than_or_equal_to: 1045,
    message: "Potential range between 1 and 22"
  }, if: :malt_category?

  private

  def hop_category?
    category_id == 1
  end

  def malt_category?
    category_id == 2
  end

  def yeast_category?
    category_id == 3
  end
end
