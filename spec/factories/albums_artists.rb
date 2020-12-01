# frozen_string_literal: true

FactoryBot.define do
  factory :album_artist, class: 'AlbumsArtists' do
    album { create(:album) }
    artist { create(:artist) }
  end
end
