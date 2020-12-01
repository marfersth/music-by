# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /songs', type: :request do
  let(:attributes) {}

  subject(:post_request) do
    post '/songs/', params: { song: attributes }, as: :json
  end

  let(:attributes) do
    {
      track_num: song.track_num,
      genre: song.genre,
      duration: song.duration,
      name: song.name,
      featured: true,
      feature_text: song.feature_text,
      image: base64_image,
      album_id: album.id,
      artists_attributes: [
        {
          name: artist.name,
          biography: artist.biography
        }
      ]
    }
  end

  let(:album) { FactoryBot.create(:album) }
  let(:song) { FactoryBot.build(:song, album: album) }
  let(:artist) { FactoryBot.build(:artist) }

  it 'creates a new song' do
    expect do
      post_request
    end.to change(Song, :count).by(1)
  end

  it 'creates an artist associates to the song' do
    expect do
      post_request
    end.to change(Artist, :count).by(1)
    expect(Artist.last.songs).to include(Song.last)
  end
end
