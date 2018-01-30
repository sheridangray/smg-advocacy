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

ActiveRecord::Schema.define(version: 20180123081955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "google_civic_apis", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "email"
    t.string   "image"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "address"
    t.string   "token"
    t.datetime "token_expires_at"
    t.string   "phone"
    t.integer  "google_civic_api_id"
    t.index ["google_civic_api_id"], name: "index_users_on_google_civic_api_id", using: :btree
  end

  add_foreign_key "users", "google_civic_apis"
end
