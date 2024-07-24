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

ActiveRecord::Schema[7.2].define(version: 2024_07_24_190727) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brand_info", primary_key: "brand_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", null: false
    t.string "state", null: false
    t.index ["brand_id"], name: "index_brand_info_on_brand_id", using: :hash
  end

  create_table "brand_product_ownership", primary_key: "ownership_id", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "brand_id", null: false
    t.uuid "product_id", null: false
    t.index ["ownership_id"], name: "index_brand_product_ownership_on_ownership_id", using: :hash
  end

  create_table "client_products", primary_key: "ownership_id", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "client_id", null: false
    t.uuid "brand_product_id", null: false
    t.string "state", null: false
    t.decimal "payout_rate", null: false
    t.index ["ownership_id"], name: "index_client_products_on_ownership_id", using: :hash
  end

  create_table "product_info", primary_key: "product_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", null: false
    t.string "state", null: false
    t.index ["product_id"], name: "index_product_info_on_product_id", using: :hash
  end

  create_table "user_info", primary_key: "user_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.index ["email"], name: "index_user_info_on_email", using: :hash
    t.index ["user_id"], name: "index_user_info_on_user_id", using: :hash
  end

  add_foreign_key "brand_product_ownership", "brand_info", column: "brand_id", primary_key: "brand_id"
  add_foreign_key "brand_product_ownership", "product_info", column: "product_id", primary_key: "product_id"
  add_foreign_key "client_products", "brand_product_ownership", column: "brand_product_id", primary_key: "ownership_id"
  add_foreign_key "client_products", "user_info", column: "client_id", primary_key: "user_id"
end
