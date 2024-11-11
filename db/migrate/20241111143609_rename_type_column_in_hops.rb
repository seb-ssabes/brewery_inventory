class RenameTypeColumnInHops < ActiveRecord::Migration[7.1]
  def change
    rename_column :hops, :type, :hop_type
  end
end
