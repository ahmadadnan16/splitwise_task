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

ActiveRecord::Schema.define(version: 2024_05_14_111452) do

  create_table "expense_items", force: :cascade do |t|
    t.text "description"
    t.decimal "amount"
    t.boolean "is_shareable"
    t.integer "expense_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expense_id"], name: "index_expense_items_on_expense_id"
    t.index ["user_id"], name: "index_expense_items_on_user_id"
  end

  create_table "expense_participants", force: :cascade do |t|
    t.integer "expense_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "owed_amount"
    t.index ["expense_id"], name: "index_expense_participants_on_expense_id"
    t.index ["user_id"], name: "index_expense_participants_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.text "description"
    t.decimal "amount"
    t.decimal "tax_amount"
    t.datetime "date"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "mobile_number"
    t.decimal "total_amount"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_expense_items", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "expense_item_id"
    t.index ["expense_item_id"], name: "index_users_expense_items_on_expense_item_id"
    t.index ["user_id", "expense_item_id"], name: "index_users_expense_items_on_user_id_and_expense_item_id", unique: true
    t.index ["user_id"], name: "index_users_expense_items_on_user_id"
  end

  add_foreign_key "expense_items", "expenses"
  add_foreign_key "expense_items", "users"
  add_foreign_key "expense_participants", "expenses"
  add_foreign_key "expense_participants", "users"
  add_foreign_key "expenses", "users"
  add_foreign_key "users_expense_items", "expense_items"
  add_foreign_key "users_expense_items", "users"
end
