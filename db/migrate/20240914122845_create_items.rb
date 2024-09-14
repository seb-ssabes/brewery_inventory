class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.float :quantity
      t.string :unit
      t.string :color
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
