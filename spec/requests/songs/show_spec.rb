# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /songs/:id', type: :request do
  subject(:get_request) do
    get "/songs/#{song.id}"
  end

  let!(:song) { FactoryBot.create(:song) }
  let(:artist) { song.artists.first }
  let(:album) { song.album }

  it 'returns the song data' do
    get_request
    expect(json).to include_json(
      id: song.id,
      track_num: song.track_num,
      genre: song.genre,
      duration: song.duration,
      name: song.name
    )
  end

  it 'returns artists data' do
    get_request
    json[:artists].each do |json_artist|
      expect(json_artist).to include_json(
        id: artist.id,
        name: artist.name,
        biography: artist.biography
      )
    end
  end

  it 'returns album data' do
    get_request
    expect(json[:album]).to include_json(
      id: album.id,
      year: album.year,
      name: album.name
    )
  end
end
