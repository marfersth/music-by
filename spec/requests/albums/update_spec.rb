# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /albums/:id', type: :request do
  let(:attributes) {}

  context 'when album is not found' do
    subject(:put_request) do
      put '/albums/1', params: attributes, as: :json
    end

    include_examples 'not successful response'
  end

  context 'when album is found' do
    subject(:put_request) do
      put "/albums/#{album.id}", params: { album: attributes }, as: :json
    end

    let!(:album) { FactoryBot.create(:album) }

    context 'when params have album attributes to update' do
      let(:attributes) do
        {
          year: new_album.year,
          name: new_album.name
        }
      end

      let(:new_album) { FactoryBot.build(:album) }

      it 'change album attributes' do
        put_request
        expect(json).to include_json(
          year: new_album.year,
          name: new_album.name
        )
      end
    end

    context 'when params have new songs to add' do
      let(:attributes) do
        {
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

      let(:song) { FactoryBot.build(:song) }

      it 'creates a new song linked to the album' do
        expect do
          put_request
        end.to change(Song, :count).by(1)
        expect(Song.last.album).to eq(album)
      end
    end

    context 'when params have songs to remove' do
      let(:attributes) do
        {
          songs_attributes: [
            {
              id: song.id,
              _destroy: true
            }
          ]
        }
      end

      let!(:song) { FactoryBot.create(:song, album: album) }

      it 'remove the song from the album' do
        expect do
          put_request
        end.to change { album.songs.count }.by(-1)
      end

      it 'remove the song' do
        expect do
          put_request
        end.to change(Song, :count).by(-1)
      end
    end
  end
end
