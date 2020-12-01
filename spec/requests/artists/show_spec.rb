# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /artists/:id', type: :request do
  subject(:get_request) do
    get "/artists/#{artist.id}"
  end

  let!(:artist) { FactoryBot.create(:artist) }

  context 'when artist have no albums or songs' do
    it 'returns artist data' do
      get_request
      expect(json).to include_json(
        id: artist.id,
        biography: artist.biography,
        name: artist.name
      )
    end

    it 'returns empty artists and songs' do
      get_request
      expect(json).to include_json(
        albums: [],
        songs: []
      )
    end
  end

  context 'when artist have albums and songs' do
    before do
      FactoryBot.create(:artist_song, song: song, artist: artist)
      FactoryBot.create(:album_artist, album: album, artist: artist)
    end

    let!(:song) { FactoryBot.create(:song) }
    let!(:album) { FactoryBot.create(:album) }

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

    it 'returns albums data' do
      get_request
      json[:albums].each do |json_album|
        expect(json_album).to include_json(
          id: album.id,
          year: album.year,
          name: album.name
        )
      end
    end
  end
end
