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

ActiveRecord::Schema.define(version: 20160604142256) do

  create_table "exams", force: :cascade do |t|
    t.integer  "activity"
    t.string   "patient"
    t.float    "srate",      default: 1000.0
    t.datetime "date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "post_attachments", force: :cascade do |t|
    t.integer  "post_id"
    t.string   "multiread"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resumes", force: :cascade do |t|
    t.string   "name"
    t.string   "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "samples", force: :cascade do |t|
    t.integer  "time"
    t.integer  "ax"
    t.integer  "ay"
    t.integer  "az"
    t.integer  "exam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "samples", ["exam_id"], name: "index_samples_on_exam_id"

end
