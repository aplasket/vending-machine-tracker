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

ActiveRecord::Schema[7.0].define(version: 2023_06_10_170439) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "machine_snacks", force: :cascade do |t|
    t.bigint "snack_id", null: false
    t.bigint "machine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machine_id"], name: "index_machine_snacks_on_machine_id"
    t.index ["snack_id"], name: "index_machine_snacks_on_snack_id"
  end

  create_table "machines", force: :cascade do |t|
    t.string "location"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_machines_on_owner_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "snacks", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "machine_snacks", "machines"
  add_foreign_key "machine_snacks", "snacks"
  add_foreign_key "machines", "owners"
end
