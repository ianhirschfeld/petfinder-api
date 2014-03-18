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

ActiveRecord::Schema.define(version: 20140318172729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animals", force: true do |t|
    t.integer  "shelter_id"
    t.text     "breed"
    t.text     "shelter_pet_id"
    t.text     "name"
    t.text     "address"
    t.text     "city"
    t.text     "state"
    t.text     "zip"
    t.text     "phone"
    t.text     "fax"
    t.text     "description"
    t.text     "sex"
    t.text     "size"
    t.text     "mix"
    t.text     "animal"
    t.text     "photos"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "animals", ["shelter_id"], name: "index_animals_on_shelter_id", using: :btree
  add_index "animals", ["shelter_pet_id"], name: "index_animals_on_shelter_pet_id", using: :btree

  create_table "shelters", force: true do |t|
    t.text     "awo_id"
    t.text     "name"
    t.text     "address"
    t.text     "city"
    t.text     "state"
    t.text     "zip"
    t.text     "phone"
    t.text     "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shelters", ["awo_id"], name: "index_shelters_on_awo_id", unique: true, using: :btree

end
