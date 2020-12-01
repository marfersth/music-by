class CreateAlbumsArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :albums_artists do |t|
      t.references :artist, foreign_key: true
      t.references :album, foreign_key: true
      t.timestamps
    end
  end
end
