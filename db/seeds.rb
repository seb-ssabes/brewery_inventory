Category.destroy_all
Item.destroy_all

hop_category = Category.create(id: 1, name:'Hops')
malt_category = Category.create(id: 2, name:'Malts')
yeast_category = Category.create(id: 3, name:'Yeasts')

hop_category.items.create([
  { name: 'Cascade', quantity: 350, unit: 'g', price: 4.000, origin: 'USA', alpha: 5.5, item_type: 'Pellet', date: Date.today, notes: '', supplier: 'Hop Supplier Co' },
  { name: 'Citra', quantity: 120, unit: 'g', price: 5.500, origin: 'Germany', alpha: 8.7, item_type: 'Whole', date: Date.today, notes: '', supplier: 'Hop Trader Ltd.' }
])

malt_category.items.create([
  { name: 'Pilsner Malt', quantity: 6500, unit: 'g', item_category: 'Base', price: 1430, origin: 'Belgium', item_type: 'Grain', date: Date.today, notes: '', supplier: 'Malt Masters Inc.', potential: 80, yield: 82 },
  { name: 'Pale Ale Malt', quantity: 3900, unit: 'g', item_category: 'Caramel', price: 1850, origin: 'Chile', item_type: 'Grain', date: Date.today, notes: '', supplier: 'Malt Supply Co.', potential: 60, yield: 75 }
])

yeast_category.items.create([
  { name: 'Wyeast 1056', quantity: 125, unit: 'ml', price: 3.990, origin: 'USA', item_type: 'Liquid', date: Date.today, notes: '', supplier: 'Yeast Labs', attenuation: 76.0 },
  { name: 'Safale US-05', quantity: 1, unit: 'sachet', price: 3.290, origin: 'France', item_type: 'Dry', date: Date.today, notes: '', supplier: 'Fermentis', attenuation: 81.0 }
])

puts "#{Category.count} categories and two items for each seeded"
