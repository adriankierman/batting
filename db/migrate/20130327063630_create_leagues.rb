class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.text :league_name
      t.references :season

      t.timestamps
    end
    add_index :leagues, :season_id
  end
end
