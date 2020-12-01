# frozen_string_literal: true

class ArtistsSongs < ApplicationRecord
  belongs_to :artist
  belongs_to :song
end
