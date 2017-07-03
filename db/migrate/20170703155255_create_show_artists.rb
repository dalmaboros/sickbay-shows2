class CreateShowArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :show_artists do |t|
      t.integer :show_id
      t.integer :artist_id
      
      t.timestamps null: false
    end
  end
end
