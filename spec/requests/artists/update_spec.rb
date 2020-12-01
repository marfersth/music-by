# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /artists/:id', type: :request do
  let(:attributes) {}

  context 'when artist is not found' do
    subject(:put_request) do
      put '/artists/1', params: attributes, as: :json
    end

    include_examples 'not successful response'
  end

  context 'when artist is found' do
    subject(:put_request) do
      put "/artists/#{artist.id}", params: { artist: attributes }, as: :json
    end

    let!(:artist) { FactoryBot.create(:artist) }

    context 'when params have artist attributes to update' do
      let(:attributes) do
        {
          biography: new_artist.biography,
          name: new_artist.name
        }
      end

      let(:new_artist) { FactoryBot.build(:artist) }

      it 'change album attributes' do
        put_request
        expect(json).to include_json(
          biography: new_artist.biography,
          name: new_artist.name
        )
      end
    end

    context 'when params have new album to add' do
      let(:attributes) do
        {
          albums_attributes: [
            {
              name: album.name,
              year: album.year
            }
          ]
        }
      end

      let(:album) { FactoryBot.build(:album) }

      it 'creates a new album linked to the artist' do
        expect do
          put_request
        end.to change(Album, :count).by(1)
        expect(Album.last.artists).to include(artist)
      end
    end

    context 'when params have albums to remove' do
      let(:attributes) do
        {
          albums_attributes: [
            {
              id: album.id,
              _destroy: true
            }
          ]
        }
      end

      let!(:album) do
        album = FactoryBot.create(:album)
        FactoryBot.create(:album_artist, album: album, artist: artist)
        album
      end

      it 'remove the album from the artist' do
        expect do
          put_request
        end.to change { artist.albums.count }.by(-1)
      end
    end
  end
end
