# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_11_11_143609) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hops", force: :cascade do |t|
    t.string "name"
    t.text "aroma"
    t.string "alpha"
    t.string "hop_type"
    t.text "substitutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.float "quantity"
    t.string "unit"
    t.string "color"
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price"
    t.string "origin"
    t.decimal "alpha"
    t.string "item_type"
    t.date "date"
    t.text "notes"
    t.string "supplier"
    t.string "item_category"
    t.decimal "potential"
    t.decimal "yield"
    t.decimal "attenuation"
    t.string "form"
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  add_foreign_key "items", "categories"
end
