# frozen_string_literal: true

FactoryBot.define do
  factory :artist_song, class: 'ArtistsSongs' do
    artist { create(:artist) }
    song { create(:song) }
  end
end
