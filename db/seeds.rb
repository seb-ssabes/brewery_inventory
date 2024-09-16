Category.destroy_all
Item.destroy_all

hop_category = Category.create(name:'Hops')
malt_category = Category.create(name:'Malts')
yeast_category = Category.create(name:'Yeasts')

hop_category.items.create([
  { name: 'Cascade', quantity: 350, unit: 'g', price: 4.000, origin: 'USA', alpha: 5.5, type: 'Pellet', date: Date.today, notes: '', supplier: 'Hop Supplier Co' },
  { name: 'Citra', quantity: 120, unit: 'g', price: 5.500, origin: 'Germany', alpha: 8.7, type: 'Whole', date: Date.today, notes: '', supplier: 'Hop Trader Ltd.' }
])

malt_category.items.create([
  { name: 'Pilsner Malt', quantity: 6.500, unit: 'g', color: 'Base', price: 1.430, origin: 'Belgium', type: 'Grain', date: Date.today, notes: '', supplier: 'Malt Masters Inc.', potential: 80.0, yield: 82.0 },
  { name: 'Pale Ale Malt', quantity: 3.900, unit: 'g', color: 'Caramel', price: 1.850, origin: 'Chile', type: 'Grain', date: Date.today, notes: '', supplier: 'Malt Supply Co.', potential: 60.0, yield: 75.0 }
])

yeast_category.items.create([
  { name: 'Wyeast 1056', quantity: 125, unit: 'ml', price: 3.990, origin: 'USA', type: 'Ale Yeast', date: Date.today, notes: '', supplier: 'Yeast Labs', attenuation: 76.0, form: 'Liquid' },
  { name: 'Safale US-05', quantity: 1, unit: 'sachet', price: 3.290, origin: 'France', type: 'Dry Yeast', date: Date.today, notes: '', supplier: 'Fermentis', attenuation: 81.0, form: 'Dry' }
])

puts "#{Category.count} categories seeded and two items for each"
