class CreateVenueArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :venue_artists do |t|
      t.integer :venue_id
      t.integer :artist_id

      t.timestamps null: false
    end
  end
end
