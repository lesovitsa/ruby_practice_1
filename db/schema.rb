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

ActiveRecord::Schema[7.2].define(version: 2024_07_30_202256) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brand_products", primary_key: "connection_id", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "brand_id", null: false
    t.uuid "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connection_id"], name: "index_brand_products_on_connection_id", using: :hash
  end

  create_table "brands", primary_key: "brand_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", null: false
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brands_on_brand_id", using: :hash
  end

  create_table "client_products", primary_key: "ownership_id", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "client_id", null: false
    t.uuid "brand_product_id", null: false
    t.string "state", null: false
    t.float "payout_rate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ownership_id"], name: "index_client_products_on_ownership_id", using: :hash
  end

  create_table "products", primary_key: "product_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", null: false
    t.string "state", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_products_on_product_id", using: :hash
  end

  create_table "users", primary_key: "user_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["email"], name: "index_users_on_email", using: :hash
    t.index ["user_id"], name: "index_users_on_user_id", using: :hash
  end

  add_foreign_key "brand_products", "brands", primary_key: "brand_id"
  add_foreign_key "brand_products", "products", primary_key: "product_id"
  add_foreign_key "client_products", "brand_products", primary_key: "connection_id"
  add_foreign_key "client_products", "users", column: "client_id", primary_key: "user_id"
end
