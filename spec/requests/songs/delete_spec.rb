# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /songs/:id', type: :request do
  subject(:delete_request) do
    delete "/songs/#{song.id}"
  end

  let!(:song) { FactoryBot.create(:song) }

  it 'delete the song record' do
    expect do
      delete_request
    end.to change(Song, :count).by(-1)
  end

  context 'when song have artists' do
    before { FactoryBot.create(:artist, songs: [song]) }

    it 'delete the artist songs relations' do
      expect do
        delete_request
      end.to change(ArtistsSongs, :count).by(-1)
    end

    it 'dont delete the Artist' do
      expect do
        delete_request
      end.to_not change(Artist, :count)
    end
  end

  context 'when song have an album' do
    before { FactoryBot.create(:album, songs: [song]) }

    it 'dont delete the albums' do
      expect do
        delete_request
      end.to_not change(Album, :count)
    end
  end
end
