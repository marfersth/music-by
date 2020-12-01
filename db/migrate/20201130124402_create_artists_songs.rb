class CreateArtistsSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :artists_songs do |t|
      t.references :artist, foreign_key: true
      t.references :song, foreign_key: true
      t.timestamps
    end
  end
end
