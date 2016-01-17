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

ActiveRecord::Schema.define(version: 20160117051654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.text     "image"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "adder_id"
    t.integer  "added_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contacts", ["added_id"], name: "index_contacts_on_added_id", using: :btree
  add_index "contacts", ["adder_id"], name: "index_contacts_on_adder_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.boolean  "delivered"
    t.integer  "sender_account"
    t.integer  "recipient_account"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "messages", ["recipient_account"], name: "index_messages_on_recipient_account", using: :btree
  add_index "messages", ["sender_account"], name: "index_messages_on_sender_account", using: :btree

end
