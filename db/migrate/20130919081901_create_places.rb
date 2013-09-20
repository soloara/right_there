class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places, :id => false do |t|
      t.string :uid, limit: 6, null: false
      t.string :name, limit: 30
      t.string :level, limit: 10
    end
    execute "ALTER TABLE places ADD PRIMARY KEY (uid);"
  end
end
