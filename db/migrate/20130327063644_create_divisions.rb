class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.text :division_name
      t.references :league

      t.timestamps
    end
    add_index :divisions, :league_id
  end
end
