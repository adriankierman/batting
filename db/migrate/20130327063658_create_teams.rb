class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.text :team_city
      t.text :team_name
      t.references :division

      t.timestamps
    end
    add_index :teams, :division_id
  end
end
