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

ActiveRecord::Schema[7.2].define(version: 2024_08_01_185348) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auths", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.uuid "userid", null: false
    t.index ["email"], name: "index_auths_on_email", unique: true
    t.index ["userid"], name: "index_auths_on_userid", unique: true
  end

  create_table "brand_ownerships", primary_key: "conn_id", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "brand_id", null: false
    t.uuid "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conn_id"], name: "index_brand_ownerships_on_conn_id", unique: true
  end

  create_table "brands", primary_key: "brand_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", null: false
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_brands_on_brand_id", unique: true
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "cards", primary_key: "card_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "card_number", null: false
    t.uuid "client_id", null: false
    t.string "activation_number", null: false
    t.string "pin"
    t.uuid "prod_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activation_number"], name: "index_cards_on_activation_number", unique: true
    t.index ["card_id"], name: "index_cards_on_card_id", unique: true
    t.index ["card_number"], name: "index_cards_on_card_number", unique: true
  end

  create_table "clears", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_products", primary_key: "conn_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "state", null: false
    t.uuid "prod_id", null: false
    t.float "payout_rate", null: false
    t.uuid "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conn_id"], name: "index_client_products_on_conn_id", unique: true
  end

  create_table "products", primary_key: "product_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name", unique: true
    t.index ["product_id"], name: "index_products_on_product_id", unique: true
  end

  add_foreign_key "brand_ownerships", "brands", primary_key: "brand_id"
  add_foreign_key "brand_ownerships", "products", primary_key: "product_id"
  add_foreign_key "cards", "auths", column: "client_id", primary_key: "userid"
  add_foreign_key "cards", "brand_ownerships", column: "prod_id", primary_key: "conn_id"
  add_foreign_key "client_products", "auths", column: "client_id", primary_key: "userid"
  add_foreign_key "client_products", "brand_ownerships", column: "prod_id", primary_key: "conn_id"
end
