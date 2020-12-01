# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /albums/:id', type: :request do
  subject(:get_request) do
    get "/albums/#{album.id}"
  end

  let!(:album) { FactoryBot.create(:album) }

  context 'when album have no artists or songs' do
    it 'returns album data' do
      get_request
      expect(json).to include_json(
        id: album.id,
        year: album.year,
        name: album.name
      )
    end

    it 'returns empty artists and songs' do
      get_request
      expect(json).to include_json(
        artists: [],
        songs: []
      )
    end
  end

  context 'when album have artists and songs' do
    let!(:song) { FactoryBot.create(:song, album: album) }
    let!(:artist) do
      album_artist = FactoryBot.create(:artist_song, song: song)
      album_artist.artist
    end

    it 'returns songs data' do
      get_request
      json[:songs].each do |json_song|
        expect(json_song).to include_json(
          id: song.id,
          track_num: song.track_num,
          genre: song.genre,
          duration: song.duration,
          name: song.name
        )
      end
    end

    it 'returns artists data' do
      get_request
      json[:artists].each do |json_artist|
        expect(json_artist).to include_json(
          id: artist.id,
          biography: artist.biography,
          name: artist.name
        )
      end
    end
  end
end
