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

ActiveRecord::Schema.define(version: 20150111225208) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "logs", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "path",        limit: 255
    t.integer  "user_id"
    t.integer  "view_count",              default: 0
    t.string   "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level",                   default: 0
    t.integer  "status",                  default: 1
  end

  add_index "logs", ["user_id"], name: "index_logs_on_user_id"

  create_table "topics", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "view_count",             default: 0
    t.boolean  "sticky",                 default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level",                  default: 0
    t.integer  "status",                 default: 1
  end

  add_index "topics", ["user_id"], name: "index_topics_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "email",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest",   limit: 255
    t.string   "activation_digest", limit: 255
    t.datetime "activated_at"
    t.string   "reset_digest",      limit: 255
    t.datetime "reset_sent_at"
    t.integer  "level",                         default: 0
    t.integer  "status",                        default: 0
    t.string   "timezone",          limit: 255
    t.datetime "last_login"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true

end
