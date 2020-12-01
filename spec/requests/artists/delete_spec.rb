# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /artists/:id', type: :request do
  subject(:delete_request) do
    delete "/artists/#{artist.id}"
  end

  let!(:artist) { FactoryBot.create(:artist) }

  it 'delete the artist record' do
    expect do
      delete_request
    end.to change(Artist, :count).by(-1)
  end

  context 'when artist have songs' do
    before { FactoryBot.create(:song, artists: [artist]) }

    it 'delete the artist songs relations' do
      expect do
        delete_request
      end.to change(ArtistsSongs, :count).by(-1)
    end

    it 'dont delete the Song' do
      expect do
        delete_request
      end.to_not change(Song, :count)
    end
  end

  context 'when artist have albums' do
    before { FactoryBot.create(:album_artist, artist: artist) }

    it 'delete the artist albums relations' do
      expect do
        delete_request
      end.to change(AlbumsArtists, :count).by(-1)
    end

    it 'dont delete the albums' do
      expect do
        delete_request
      end.to_not change(Album, :count)
    end
  end
end
