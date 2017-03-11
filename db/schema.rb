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

ActiveRecord::Schema.define(version: 20150402084714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_type"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "flag_replies", force: :cascade do |t|
    t.integer  "reply_id"
    t.integer  "user_id"
    t.integer  "flag_id"
    t.boolean  "seen",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "flag_replies", ["flag_id"], name: "index_flag_replies_on_flag_id", using: :btree
  add_index "flag_replies", ["reply_id"], name: "index_flag_replies_on_reply_id", using: :btree
  add_index "flag_replies", ["user_id"], name: "index_flag_replies_on_user_id", using: :btree

  create_table "flag_skoots", force: :cascade do |t|
    t.integer  "skoot_id"
    t.integer  "user_id"
    t.integer  "flag_id"
    t.boolean  "seen",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "flag_skoots", ["flag_id"], name: "index_flag_skoots_on_flag_id", using: :btree
  add_index "flag_skoots", ["skoot_id"], name: "index_flag_skoots_on_skoot_id", using: :btree
  add_index "flag_skoots", ["user_id"], name: "index_flag_skoots_on_user_id", using: :btree

  create_table "flags", force: :cascade do |t|
    t.string "name"
  end

  create_table "like_replies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "reply_id"
  end

  add_index "like_replies", ["reply_id"], name: "index_like_replies_on_reply_id", using: :btree
  add_index "like_replies", ["user_id"], name: "index_like_replies_on_user_id", using: :btree

  create_table "like_skoots", force: :cascade do |t|
    t.integer "user_id"
    t.integer "skoot_id"
  end

  add_index "like_skoots", ["skoot_id"], name: "index_like_skoots_on_skoot_id", using: :btree
  add_index "like_skoots", ["user_id"], name: "index_like_skoots_on_user_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "lat"
    t.float    "lng"
    t.integer  "count",      default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "locations", ["user_id"], name: "index_locations_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "type_id"
    t.boolean  "read",       default: false
    t.integer  "counter",    default: 1
    t.integer  "skoot_id"
    t.integer  "reply_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "notifications", ["reply_id"], name: "index_notifications_on_reply_id", using: :btree
  add_index "notifications", ["skoot_id"], name: "index_notifications_on_skoot_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "replies", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "skoot_id"
    t.boolean  "deleted_user",      default: false
    t.boolean  "deleted_moderator", default: false
    t.boolean  "deleted_auto",      default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "anonymous"
  end

  add_index "replies", ["skoot_id"], name: "index_replies_on_skoot_id", using: :btree
  add_index "replies", ["user_id"], name: "index_replies_on_user_id", using: :btree

  create_table "skoot_images", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "height"
    t.integer  "width"
    t.integer  "skoot_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "skoot_images", ["skoot_id"], name: "index_skoot_images_on_skoot_id", using: :btree

  create_table "skoots", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "category_id"
    t.integer  "location_id"
    t.boolean  "deleted_moderator", default: false
    t.boolean  "deleted_user",      default: false
    t.boolean  "deleted_auto",      default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "anonymous"
  end

  add_index "skoots", ["category_id"], name: "index_skoots_on_category_id", using: :btree
  add_index "skoots", ["location_id"], name: "index_skoots_on_location_id", using: :btree
  add_index "skoots", ["user_id"], name: "index_skoots_on_user_id", using: :btree

  create_table "user_following_categories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "zone_id"
    t.integer "category_id"
  end

  add_index "user_following_categories", ["category_id"], name: "index_user_following_categories_on_category_id", using: :btree
  add_index "user_following_categories", ["user_id"], name: "index_user_following_categories_on_user_id", using: :btree
  add_index "user_following_categories", ["zone_id"], name: "index_user_following_categories_on_zone_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "device"
    t.string   "access_token"
    t.string   "name"
    t.string   "email"
    t.string   "registration_id"
    t.boolean  "notify",            default: true
    t.boolean  "deleted_moderator", default: false
    t.boolean  "deleted_auto",      default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "zone_categories", id: false, force: :cascade do |t|
    t.integer "zone_id"
    t.integer "category_id"
  end

  add_index "zone_categories", ["category_id"], name: "index_zone_categories_on_category_id", using: :btree
  add_index "zone_categories", ["zone_id"], name: "index_zone_categories_on_zone_id", using: :btree

  create_table "zones", force: :cascade do |t|
    t.string   "name"
    t.float    "lat_min"
    t.float    "lat_max"
    t.float    "lng_min"
    t.float    "lng_max"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_foreign_key "flag_replies", "flags"
  add_foreign_key "flag_replies", "replies"
  add_foreign_key "flag_replies", "users"
  add_foreign_key "flag_skoots", "flags"
  add_foreign_key "flag_skoots", "skoots"
  add_foreign_key "flag_skoots", "users"
  add_foreign_key "like_replies", "replies"
  add_foreign_key "like_replies", "users"
  add_foreign_key "like_skoots", "skoots"
  add_foreign_key "like_skoots", "users"
  add_foreign_key "locations", "users"
  add_foreign_key "notifications", "replies"
  add_foreign_key "notifications", "skoots"
  add_foreign_key "notifications", "users"
  add_foreign_key "replies", "skoots"
  add_foreign_key "replies", "users"
  add_foreign_key "skoot_images", "skoots"
  add_foreign_key "skoots", "categories"
  add_foreign_key "skoots", "locations"
  add_foreign_key "skoots", "users"
  add_foreign_key "user_following_categories", "categories"
  add_foreign_key "user_following_categories", "users"
  add_foreign_key "user_following_categories", "zones"
  add_foreign_key "zone_categories", "categories"
  add_foreign_key "zone_categories", "zones"
end
