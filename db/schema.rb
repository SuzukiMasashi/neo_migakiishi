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

ActiveRecord::Schema.define(version: 20160325140539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.integer  "version_id"
    t.string   "code"
    t.integer  "cost"
    t.string   "name"
    t.integer  "card_class"
    t.integer  "card_set"
    t.integer  "card_type"
    t.integer  "race"
    t.integer  "rarity"
    t.boolean  "collectible"
    t.string   "card_text"
    t.integer  "attack"
    t.integer  "health"
    t.integer  "durability"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "cards", ["version_id", "code"], name: "index_cards_on_version_id_and_code", unique: true, using: :btree
  add_index "cards", ["version_id"], name: "index_cards_on_version_id", using: :btree

  create_table "cards_import_jobs", force: :cascade do |t|
    t.integer  "version_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cards_import_jobs", ["version_id"], name: "index_cards_import_jobs_on_version_id", using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cards", "versions"
  add_foreign_key "cards_import_jobs", "versions"
end
