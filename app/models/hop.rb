require 'csv'

class Hop < ApplicationRecord
  def self.load_hops_data
    filepath = Rails.root.join('db', 'hops_data.csv')
    hops = []

    unless File.exist?(filepath)
      puts "CSV file not found at: #{filepath}"
      return
    end

    CSV.foreach(filepath, headers: true) do |row|
      puts row.inspect

      hops << {
        name: row['Lúpulo'],
        aroma: row['Aroma/Sabor'],
        alpha: row['Alpha'],
        hop_type: row['Tipo'],
        substitutes: row['Sustitutos']
      }
    end

    hops
  end
end
