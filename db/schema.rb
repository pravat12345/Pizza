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

ActiveRecord::Schema[7.1].define(version: 2025_02_09_100833) do
  create_table "crusts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extras", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.integer "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.string "scopes"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "order_extras", force: :cascade do |t|
    t.integer "order_item_id", null: false
    t.integer "extra_id", null: false
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["extra_id"], name: "index_order_extras_on_extra_id"
    t.index ["order_item_id"], name: "index_order_extras_on_order_item_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "pizza_id", null: false
    t.integer "pizza_variant_id", null: false
    t.integer "crust_id", null: false
    t.decimal "price"
    t.integer "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crust_id"], name: "index_order_items_on_crust_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["pizza_id"], name: "index_order_items_on_pizza_id"
    t.index ["pizza_variant_id"], name: "index_order_items_on_pizza_variant_id"
  end

  create_table "order_sides", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "side_id", null: false
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_sides_on_order_id"
    t.index ["side_id"], name: "index_order_sides_on_side_id"
  end

  create_table "order_toppings", force: :cascade do |t|
    t.integer "order_item_id", null: false
    t.integer "topping_id", null: false
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_item_id"], name: "index_order_toppings_on_order_item_id"
    t.index ["topping_id"], name: "index_order_toppings_on_topping_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "total_price"
    t.string "customer_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pizza_variants", force: :cascade do |t|
    t.string "variant"
    t.decimal "price"
    t.integer "pizza_id", null: false
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pizza_id"], name: "index_pizza_variants_on_pizza_id"
  end

  create_table "pizzas", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rule_engines", force: :cascade do |t|
    t.integer "category"
    t.string "rule_category"
    t.string "type_of_rule"
    t.string "values"
    t.string "variantsizes"
    t.integer "count_value"
    t.string "error_message_local_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sides", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topping_pizza_exclusions", force: :cascade do |t|
    t.integer "category"
    t.integer "topping_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topping_id"], name: "index_topping_pizza_exclusions_on_topping_id"
  end

  create_table "toppings", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "order_extras", "extras"
  add_foreign_key "order_extras", "order_items"
  add_foreign_key "order_items", "crusts"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "pizza_variants"
  add_foreign_key "order_items", "pizzas"
  add_foreign_key "order_sides", "orders"
  add_foreign_key "order_sides", "sides"
  add_foreign_key "order_toppings", "order_items"
  add_foreign_key "order_toppings", "toppings"
  add_foreign_key "pizza_variants", "pizzas"
  add_foreign_key "topping_pizza_exclusions", "toppings"
end
