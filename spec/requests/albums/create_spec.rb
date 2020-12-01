# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /albums', type: :request do
  let(:attributes) {}

  subject(:post_request) do
    post '/albums/', params: { album: attributes }, as: :json
  end

  let(:attributes) do
    {
      year: album.year,
      name: album.name,
      songs_attributes: [
        {
          track_num: song.track_num,
          genre: song.genre,
          duration: song.duration,
          name: song.name,
          featured: song.featured,
          feature_text: song.feature_text
        }
      ]
    }
  end

  let(:song) { FactoryBot.build(:song, album: nil) }
  let(:album) { FactoryBot.build(:album) }

  it 'creates a new album' do
    expect do
      post_request
    end.to change(Album, :count).by(1)
  end

  it 'creates the song associates to the album' do
    expect do
      post_request
    end.to change(Song, :count).by(1)
    expect(Song.last.album).to eq(Album.last)
  end
end
