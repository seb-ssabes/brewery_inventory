class CreateHops < ActiveRecord::Migration[7.1]
  def change
    create_table :hops do |t|
      t.string :name
      t.text :aroma
      t.string :alpha
      t.string :type
      t.text :substitutes

      t.timestamps
    end
  end
end
