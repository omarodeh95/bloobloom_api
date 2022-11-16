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

ActiveRecord::Schema[7.0].define(version: 2022_11_16_034234) do
  create_table "frame_prices", force: :cascade do |t|
    t.float "price"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "frame_id"
    t.index ["frame_id"], name: "index_frame_prices_on_frame_id"
  end

  create_table "frames", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "status"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lense_prices", force: :cascade do |t|
    t.float "price"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lense_id"
    t.index ["lense_id"], name: "index_lense_prices_on_lense_id"
  end

  create_table "lenses", force: :cascade do |t|
    t.string "colour"
    t.text "description"
    t.string "prescription_type"
    t.string "lens_type"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "password_digest"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "frame_prices", "frames"
  add_foreign_key "lense_prices", "lenses"
end
