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

ActiveRecord::Schema.define(version: 2019_02_07_193042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "frameworks", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.bigint "language_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_frameworks_on_language_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "amount", precision: 15, scale: 2, default: "0.0"
    t.bigint "product_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "author_id"
    t.decimal "net_amount", precision: 15, scale: 2, default: "0.0"
    t.decimal "fees_amount", precision: 15, scale: 2, default: "0.0"
    t.integer "fee_percentage", default: 15
    t.json "stripe_response_data", default: {}
    t.string "product_name"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_orders_on_deleted_at"
    t.index ["product_id"], name: "index_orders_on_product_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_subtypes", force: :cascade do |t|
    t.string "name"
    t.bigint "product_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["product_type_id"], name: "index_product_subtypes_on_product_type_id"
  end

  create_table "product_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.decimal "price", precision: 15, scale: 2, default: "0.0"
    t.text "features"
    t.string "search_terms"
    t.integer "views_count", default: 0
    t.integer "checkouts_count", default: 0
    t.datetime "deleted_at"
    t.bigint "product_type_id"
    t.string "ruby_version"
    t.string "rails_version"
    t.boolean "is_approved", default: false
    t.boolean "is_active", default: false
    t.string "github_repo_id"
    t.string "github_repo_language"
    t.string "github_repo_type"
    t.string "github_repo_name"
    t.bigint "product_subtype_id"
    t.text "demo_instruction"
    t.string "demo_frontend_url"
    t.string "demo_backend_url"
    t.bigint "language_id"
    t.bigint "framework_id"
    t.bigint "category_id"
    t.integer "downloads_count", default: 0
    t.integer "purchases_count", default: 0
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
    t.index ["framework_id"], name: "index_products_on_framework_id"
    t.index ["language_id"], name: "index_products_on_language_id"
    t.index ["product_subtype_id"], name: "index_products_on_product_subtype_id"
    t.index ["product_type_id"], name: "index_products_on_product_type_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "stripe_user_id"
    t.string "stripe_publishable_key"
    t.string "company_name"
    t.datetime "deleted_at"
    t.boolean "is_admin", default: false
    t.string "provider"
    t.string "uid"
    t.string "github_token"
    t.string "github_login"
    t.string "github_avatar"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "frameworks", "languages"
  add_foreign_key "orders", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "product_subtypes", "product_types"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "frameworks"
  add_foreign_key "products", "languages"
  add_foreign_key "products", "product_subtypes"
  add_foreign_key "products", "product_types"
  add_foreign_key "products", "users"
end
