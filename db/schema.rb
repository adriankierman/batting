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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130327064222) do

  create_table "divisions", :force => true do |t|
    t.text     "division_name"
    t.integer  "league_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "divisions", ["league_id"], :name => "index_divisions_on_league_id"

  create_table "leagues", :force => true do |t|
    t.text     "league_name"
    t.integer  "season_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "leagues", ["season_id"], :name => "index_leagues_on_season_id"

  create_table "players", :force => true do |t|
    t.text     "surname"
    t.integer  "team_id"
    t.text     "given_name"
    t.text     "position"
    t.float    "games"
    t.float    "games_started"
    t.float    "at_bats"
    t.float    "runs"
    t.float    "hits"
    t.float    "doubles"
    t.float    "triples"
    t.float    "home_runs"
    t.float    "rbi"
    t.float    "steals"
    t.float    "caught_stealing"
    t.float    "sacrifice_hits"
    t.float    "sacrifice_flies"
    t.float    "mistakes"
    t.float    "pb"
    t.float    "walks"
    t.float    "struck_out"
    t.float    "hit_by_pitch"
    t.float    "throws"
    t.float    "wins"
    t.float    "losses"
    t.float    "saves"
    t.float    "complete_games"
    t.float    "shut_outs"
    t.float    "era"
    t.float    "innings"
    t.float    "earned_runs"
    t.float    "hit_batter"
    t.float    "wild_pitches"
    t.float    "balk"
    t.float    "walked_batter"
    t.float    "struck_out_batter"
    t.float    "on_base_percentage_plus_slugging"
    t.float    "batting_average"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "players", ["team_id"], :name => "index_players_on_team_id"

  create_table "seasons", :force => true do |t|
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.text     "team_city"
    t.text     "team_name"
    t.integer  "division_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "teams", ["division_id"], :name => "index_teams_on_division_id"

end
