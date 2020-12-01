class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.integer :year
      t.string :name
      t.timestamps
    end
  end
end
