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

ActiveRecord::Schema[7.0].define(version: 2022_09_15_150331) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "halls", force: :cascade do |t|
    t.string "name"
    t.integer "capacity"
    t.decimal "cost"
    t.string "image"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "created_by_id", null: false
    t.index ["created_by_id"], name: "index_halls_on_created_by_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "admin_id"
    t.bigint "recipient_id"
    t.text "text"
    t.bigint "reserve_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_notifications_on_admin_id"
    t.index ["recipient_id"], name: "index_notifications_on_recipient_id"
    t.index ["reserve_id"], name: "index_notifications_on_reserve_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "reserve_date"
    t.string "status"
    t.bigint "user_id", null: false
    t.bigint "hall_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hall_id"], name: "index_reservations_on_hall_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "role", default: "user"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "halls", "users", column: "created_by_id"
  add_foreign_key "notifications", "reservations", column: "reserve_id"
  add_foreign_key "notifications", "users", column: "admin_id"
  add_foreign_key "notifications", "users", column: "recipient_id"
  add_foreign_key "reservations", "halls"
  add_foreign_key "reservations", "users"
end
