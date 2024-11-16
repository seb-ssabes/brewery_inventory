require 'csv'

class Hop < ApplicationRecord
  def self.load_hops_data
    filepath = Rails.root.join('db', 'hops_data.csv')
    hops = []

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

  def self.find_substitutes(hop_name)
    hops_data = load_hops_data
    matches = hops_data.select { |h| h[:name]&.downcase&.include?(hop_name.downcase) }

    return [] if matches.empty?

    if matches.size == 1
      substitutes = matches.first[:substitutes]
      substitutes.present? ? substitutes.split(',').map(&:strip) : "No substitutes found"
    else
      matches.map do |hop|
        hop_name = hop[:name]
        substitutes = hop[:substitutes].present? ? hop[:substitutes].split(',').map(&:strip).join(' | ') : 'No substitutes found'
        "#{hop_name} → #{substitutes}"
      end
    end
  end
end
