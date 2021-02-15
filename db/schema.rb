# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_15_023011) do

  create_table "details", force: :cascade do |t|
    t.string "date"
    t.time "time"
    t.text "schedule"
    t.text "note"
    t.integer "sort"
    t.integer "plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_details_on_plan_id"
  end

  create_table "outlines", force: :cascade do |t|
    t.string "date"
    t.string "time"
    t.text "schedule"
    t.text "note"
    t.integer "sort"
    t.integer "plan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plan_id"], name: "index_outlines_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.date "start"
    t.date "end"
    t.string "days"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
  end

  add_foreign_key "details", "plans"
  add_foreign_key "outlines", "plans"
  add_foreign_key "plans", "users"
end
