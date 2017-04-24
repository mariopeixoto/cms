# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170419025704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "contact_name"
    t.string   "contact_phone"
    t.text     "address"
    t.float    "default_fine",     default: 2.0
    t.float    "default_interest", default: 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "condos", force: :cascade do |t|
    t.string   "name",       null: false
    t.text     "address"
    t.integer  "client_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "condos", ["client_id"], name: "index_condos_on_client_id", using: :btree

  create_table "debts", force: :cascade do |t|
    t.string   "description"
    t.float    "original_amount",                 null: false
    t.date     "due_date",                        null: false
    t.string   "debt_type",                       null: false
    t.integer  "unit_id",                         null: false
    t.integer  "tenant_id",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid",            default: false
    t.boolean  "notified",        default: false
  end

  add_index "debts", ["tenant_id"], name: "index_debts_on_tenant_id", using: :btree
  add_index "debts", ["unit_id"], name: "index_debts_on_unit_id", using: :btree

  create_table "imports", force: :cascade do |t|
    t.string   "debt_report"
    t.string   "status",      default: "waiting"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenants", force: :cascade do |t|
    t.string   "name",            null: false
    t.text     "billing_address", null: false
    t.string   "ssn",             null: false
    t.string   "phone_number",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "units", force: :cascade do |t|
    t.string   "number",        null: false
    t.string   "building_name", null: false
    t.integer  "condo_id",      null: false
    t.integer  "tenant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "units", ["condo_id"], name: "index_units_on_condo_id", using: :btree
  add_index "units", ["tenant_id"], name: "index_units_on_tenant_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "condos", "clients"
  add_foreign_key "debts", "tenants"
  add_foreign_key "debts", "units"
  add_foreign_key "units", "condos"
  add_foreign_key "units", "tenants"
end
