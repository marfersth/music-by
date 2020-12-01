class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.integer :track_num
      t.string :genre
      t.integer :duration
      t.string :name
      t.boolean :featured
      t.text :feature_text
      t.timestamps
    end
  end
end
