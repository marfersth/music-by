# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /artists', type: :request do
  let(:attributes) {}

  subject(:post_request) do
    post '/artists/', params: { artist: attributes }, as: :json
  end

  let(:attributes) do
    {
      biography: artist.biography,
      name: artist.name,
      albums_attributes: [
        {
          year: album.year,
          name: album.name
        }
      ]
    }
  end

  let(:artist) { FactoryBot.build(:artist) }
  let(:album) { FactoryBot.build(:album) }

  it 'creates a new artist' do
    expect do
      post_request
    end.to change(Artist, :count).by(1)
  end

  it 'creates the album associates to the artist' do
    expect do
      post_request
    end.to change(Album, :count).by(1)
    expect(Album.last.artists).to include(Artist.last)
  end

  context 'when creates the artist with an existing album' do
    let(:attributes) do
      {
        biography: artist.biography,
        name: artist.name,
        albums_attributes: [
          {
            id: album.id
          }
        ]
      }
    end

    let(:artist) { FactoryBot.build(:artist) }
    let!(:album) { FactoryBot.create(:album) }

    it 'creates a new artist' do
      expect do
        post_request
      end.to change(Artist, :count).by(1)
    end

    it 'associates the album to the artist' do
      post_request
      expect(Album.last.artists).to include(Artist.last)
    end
  end
end
