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

ActiveRecord::Schema.define(version: 2023_02_02_201627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.integer "runtime"
    t.string "genre"
    t.text "summary"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
  end

  create_table "viewing_parties", force: :cascade do |t|
    t.string "duration"
    t.datetime "party_date"
    t.bigint "movie_id"
    t.integer "host_id"
    t.index ["movie_id"], name: "index_viewing_parties_on_movie_id"
  end

  create_table "viewing_party_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "viewing_party_id"
    t.index ["user_id"], name: "index_viewing_party_users_on_user_id"
    t.index ["viewing_party_id"], name: "index_viewing_party_users_on_viewing_party_id"
  end

  add_foreign_key "viewing_parties", "movies"
  add_foreign_key "viewing_party_users", "users"
  add_foreign_key "viewing_party_users", "viewing_parties"
end
