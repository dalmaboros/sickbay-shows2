class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :date
      t.integer :venue_id
      t.string :url
      
      t.timestamps null: false
    end
  end
end
