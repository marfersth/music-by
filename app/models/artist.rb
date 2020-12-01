# frozen_string_literal: true

class Artist < ApplicationRecord
  has_many :artists_songs, class_name: 'ArtistsSongs', dependent: :destroy
  has_many :songs, through: :artists_songs, inverse_of: :artists
  has_many :albums_artists, class_name: 'AlbumsArtists', dependent: :destroy
  has_many :albums, through: :albums_artists, inverse_of: :artists

  accepts_nested_attributes_for :albums, allow_destroy: true

  def albums_attributes=(attributes)
    attributes.each do |attribute|
      albums << Album.find(attribute['id']) if attribute['id'].present? && !albums.map(&:id).include?(attribute['id'])
    end
    super
  end
end
