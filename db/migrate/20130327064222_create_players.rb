class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.text :surname
      t.references :team
      t.text :given_name
      t.text :position
      t.float :games
      t.float :games_started
      t.float :at_bats
      t.float :runs
      t.float :hits
      t.float :doubles
      t.float :triples
      t.float :home_runs
      t.float :rbi
      t.float :steals
      t.float :caught_stealing
      t.float :sacrifice_hits
      t.float :sacrifice_flies
      t.float :mistakes
      t.float :pb
      t.float :walks
      t.float :struck_out
      t.float :hit_by_pitch
      t.float :throws
      t.float :wins
      t.float :losses
      t.float :saves
      t.float :complete_games
      t.float :shut_outs
      t.float :era
      t.float :innings
      t.float :earned_runs
      t.float :hit_batter
      t.float :wild_pitches
      t.float :balk
      t.float :walked_batter
      t.float :struck_out_batter
      t.float :on_base_percentage_plus_slugging
      t.float :batting_average

      t.timestamps
    end
    add_index :players, :team_id
  end
end
