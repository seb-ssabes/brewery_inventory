class Item < ApplicationRecord
  belongs_to :category

  validates :name, :quantity, :unit, :price, :origin, :supplier, presence: true
end
