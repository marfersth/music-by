# frozen_string_literal: true

class Album < ApplicationRecord
  has_many :songs, dependent: :destroy
  has_many :albums_artists, class_name: 'AlbumsArtists', dependent: :destroy
  has_many :artists, through: :albums_artists, inverse_of: :albums

  accepts_nested_attributes_for :songs, allow_destroy: true
end
