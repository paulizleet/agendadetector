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

ActiveRecord::Schema.define(version: 20180912170248) do

  create_table "archive_counters", force: :cascade do |t|
    t.string   "chan_board_id"
    t.string   "text_hash"
    t.integer  "occurrences"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["chan_board_id"], name: "index_archive_counters_on_chan_board_id"
  end

  create_table "archive_posts", force: :cascade do |t|
    t.integer  "archive_thread_id"
    t.string   "chan_board_id"
    t.string   "text_hash"
    t.string   "post_num"
    t.string   "poster_id"
    t.string   "text"
    t.string   "post_timestamp"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["archive_thread_id"], name: "index_archive_posts_on_archive_thread_id"
  end

  create_table "archive_threads", force: :cascade do |t|
    t.integer  "chan_board_id"
    t.string   "op"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["chan_board_id"], name: "index_archive_threads_on_chan_board_id"
  end

  create_table "chan_boards", force: :cascade do |t|
    t.string "board_id"
    t.string "board_name"
  end

  create_table "chan_threads", force: :cascade do |t|
    t.integer  "chan_board_id"
    t.string   "op"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["chan_board_id"], name: "index_chan_threads_on_chan_board_id"
  end

  create_table "nat_flags", force: :cascade do |t|
    t.string   "flag_id"
    t.string   "flag_name"
    t.boolean  "troll"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_counters", force: :cascade do |t|
    t.string   "chan_board_id"
    t.string   "text_hash"
    t.integer  "occurrences"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "chan_thread_id"
    t.string   "chan_board_id"
    t.string   "text_hash"
    t.string   "post_num"
    t.string   "poster_id"
    t.string   "nat_flag"
    t.string   "text"
    t.string   "post_timestamp"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["chan_thread_id"], name: "index_posts_on_chan_thread_id"
  end

end
