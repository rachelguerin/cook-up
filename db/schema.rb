# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160316151637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classifications", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "classifications_recipes", force: :cascade do |t|
    t.integer "classification_id"
    t.integer "recipe_id"
  end

  add_index "classifications_recipes", ["classification_id"], name: "index_classifications_recipes_on_classification_id", using: :btree
  add_index "classifications_recipes", ["recipe_id"], name: "index_classifications_recipes_on_recipe_id", using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.string   "food_type"
    t.boolean  "auto_list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quantities", force: :cascade do |t|
    t.float    "quantity"
    t.string   "unit"
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "quantities", ["ingredient_id"], name: "index_quantities_on_ingredient_id", using: :btree
  add_index "quantities", ["recipe_id"], name: "index_quantities_on_recipe_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "title"
    t.integer  "cook_time"
    t.integer  "servings"
    t.text     "method"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image_url"
    t.integer  "original_id"
    t.string   "source_url"
  end

end
