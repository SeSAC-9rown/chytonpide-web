# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_11_25_185152) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "devices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "model"
    t.string "serial"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "kits", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "device_id", null: false
    t.integer "fertilizer_interval_days"
    t.string "kind"
    t.string "name"
    t.date "planted_at"
    t.datetime "updated_at", null: false
    t.integer "watering_interval_days"
    t.index ["device_id"], name: "index_kits_on_device_id"
  end

  create_table "logs", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.date "logged_on"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "sensor_data", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.float "humidity"
    t.float "illuminance"
    t.string "serial"
    t.float "temperature"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "provider"
    t.string "social_avatar_url"
    t.string "uid"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "devices", "users"
  add_foreign_key "kits", "devices"
  add_foreign_key "logs", "users"
end
