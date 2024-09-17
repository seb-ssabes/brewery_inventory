class Item < ApplicationRecord
  belongs_to :category

  validates :name, :quantity, :price, :origin, :supplier, presence: true
end
