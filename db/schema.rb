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

ActiveRecord::Schema.define(version: 20140213053112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accepted_payments", force: true do |t|
    t.integer  "market_id"
    t.integer  "payment_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accepted_payments", ["market_id"], name: "index_accepted_payments_on_market_id", using: :btree
  add_index "accepted_payments", ["payment_type_id"], name: "index_accepted_payments_on_payment_type_id", using: :btree

  create_table "addresses", force: true do |t|
    t.integer  "market_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "zipcode"
    t.decimal  "lat",         precision: 10, scale: 6
    t.decimal  "long",        precision: 10, scale: 6
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["lat"], name: "index_addresses_on_lat", using: :btree
  add_index "addresses", ["long"], name: "index_addresses_on_long", using: :btree
  add_index "addresses", ["market_id"], name: "index_addresses_on_market_id", using: :btree

  create_table "markets", force: true do |t|
    t.integer  "fmid"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offerings", force: true do |t|
    t.integer "market_id"
    t.integer "product_id"
  end

  add_index "offerings", ["market_id"], name: "index_offerings_on_market_id", using: :btree
  add_index "offerings", ["product_id"], name: "index_offerings_on_product_id", using: :btree

  create_table "payment_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.integer  "season_id"
    t.integer  "day"
    t.string   "start_time"
    t.string   "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["season_id"], name: "index_schedules_on_season_id", using: :btree

  create_table "seasons", force: true do |t|
    t.integer  "market_id"
    t.integer  "season_number"
    t.string   "start_month"
    t.string   "end_month"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seasons", ["market_id"], name: "index_seasons_on_market_id", using: :btree

end
