# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /albums/:id', type: :request do
  subject(:delete_request) do
    delete "/albums/#{album.id}"
  end

  let!(:album) { FactoryBot.create(:album) }

  it 'delete the album record' do
    expect do
      delete_request
    end.to change(Album, :count).by(-1)
  end

  context 'when album have songs' do
    before { FactoryBot.create(:song, album: album) }

    it 'delete the songs' do
      expect do
        delete_request
      end.to change(Song, :count).by(-1)
    end
  end

  context 'when album have artists' do
    before do
      artist = FactoryBot.create(:artist)
      FactoryBot.create(:album_artist, album: album, artist: artist)
    end

    it 'delete the album artists relations' do
      expect do
        delete_request
      end.to change(AlbumsArtists, :count).by(-1)
    end

    it 'dont delete the artists' do
      expect do
        delete_request
      end.to_not change(Artist, :count)
    end
    it 'aaa' do
      delete_request
      response
    end
  end
end
