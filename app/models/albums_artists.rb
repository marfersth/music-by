# frozen_string_literal: true

class AlbumsArtists < ApplicationRecord
  belongs_to :artist
  belongs_to :album
end
