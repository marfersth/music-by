class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.text :biography
      t.string :name
      t.timestamps
    end
  end
end
