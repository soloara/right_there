class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :place_id, null: false
      t.string  :email
      t.timestamps
    end
  end
end
