class Item < ApplicationRecord
  belongs_to :category

  validate :must_have_changes, on: :update

  validates :name, :quantity, :price, :origin, :supplier, presence: true

  validates :alpha, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 25,
    message: "acids range from 1% to 22%"
  }, if: :hop_category?

  validates :potential, numericality: {
    greater_than_or_equal_to: 1000,
    less_than_or_equal_to: 1045,
    message: "range from 1000 to 1045",
    allow_nil: true
  }, if: :malt_category?

  validates :yield, numericality: {
    greater_than_or_equal_to: 60,
    less_than_or_equal_to: 85,
    message: "range from 60% to 85%",
    allow_nil: true
  }, if: :malt_category?

  validates :attenuation, numericality: {
    greater_than_or_equal_to: 60,
    less_than_or_equal_to: 90,
    message: "range from 60% to 90%",
    allow_nil: true
  }, if: :yeast_category?

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

  def must_have_changes
    return unless persisted?
    unless changed?
      errors.add(:base, "No changes detected")
    end
  end
end
