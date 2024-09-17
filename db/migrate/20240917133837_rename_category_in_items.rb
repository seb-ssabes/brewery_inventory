class RenameCategoryInItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :category, :item_category
  end
end
