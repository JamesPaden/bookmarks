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

ActiveRecord::Schema.define(version: 20140319221511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmark_tag_associations", force: true do |t|
    t.integer  "tag_id"
    t.integer  "bookmark_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmark_tag_associations", ["tag_id", "bookmark_id"], name: "index_bookmark_tag_associations_on_tag_id_and_bookmark_id", unique: true, using: :btree

  create_table "bookmarks", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "url"
    t.text     "page_text"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "domain"
    t.string   "page_title"
  end

  add_index "bookmarks", ["url", "user_id"], name: "index_bookmarks_on_url_and_user_id", unique: true, using: :btree

  create_table "keywords", force: true do |t|
    t.integer "bookmark_id"
    t.string  "keyword"
    t.float   "relevance"
  end

  create_table "tags", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "tag_type"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["user_id", "title", "tag_type", "tag_id"], name: "index_tags_on_user_id_and_title_and_tag_type_and_tag_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
