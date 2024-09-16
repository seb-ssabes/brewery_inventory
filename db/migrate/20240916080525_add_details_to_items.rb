class AddDetailsToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :price, :decimal
    add_column :items, :origin, :string
    add_column :items, :alpha, :decimal
    add_column :items, :type, :string
    add_column :items, :date, :date
    add_column :items, :notes, :text
    add_column :items, :supplier, :string
    add_column :items, :category, :string
    add_column :items, :potential, :decimal
    add_column :items, :yield, :decimal
    add_column :items, :attenuation, :decimal
    add_column :items, :form, :string
  end
end
