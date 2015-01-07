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

ActiveRecord::Schema.define(version: 20150107221004) do

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "logs", force: true do |t|
    t.string   "title"
    t.string   "path"
    t.integer  "user_id"
    t.integer  "view_count",  default: 0
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level",       default: 0
    t.integer  "status",      default: 1
  end

  add_index "logs", ["user_id"], name: "index_logs_on_user_id"

  create_table "topics", force: true do |t|
    t.string   "title"
    t.integer  "view_count", default: 0
    t.boolean  "sticky",     default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level",      default: 0
    t.integer  "status",     default: 1
  end

  add_index "topics", ["user_id"], name: "index_topics_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "activation_digest"
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "level",             default: 0
    t.integer  "status",            default: 0
    t.string   "timezone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true

end
