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

ActiveRecord::Schema.define(version: 20171009164232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string   "body",         null: false
    t.datetime "published_at", null: false
    t.integer  "author_id",    null: false
    t.integer  "post_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["author_id"], name: "index_comments_on_author_id", using: :btree
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",        null: false
    t.string   "body",         null: false
    t.integer  "author_id",    null: false
    t.datetime "published_at", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["author_id"], name: "index_posts_on_author_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname",            null: false
    t.string   "email",               null: false
    t.string   "password_digest",     null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["nickname"], name: "index_users_on_nickname", unique: true, using: :btree
  end

  add_foreign_key "comments", "users", column: "author_id"
  add_foreign_key "posts", "users", column: "author_id"
end
