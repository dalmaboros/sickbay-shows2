class CreateShowArtists < ActiveRecord::Migration
  def change
    create_table :show_artists do |t|
      t.integer :show_id
      t.integer :artist_id
      
      t.timestamps null: false
    end
  end
end
