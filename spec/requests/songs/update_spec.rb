# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT /songs/:id', type: :request do
  let(:attributes) {}

  context 'when song is not found' do
    subject(:put_request) do
      put '/songs/1', params: attributes, as: :json
    end

    include_examples 'not successful response'
  end

  context 'when song is found' do
    subject(:put_request) do
      put "/songs/#{song.id}", params: { song: attributes }, as: :json
    end

    let!(:song) { FactoryBot.create(:song) }

    context 'when params have song attributes to update' do
      let(:attributes) do
        {
          track_num: new_song.track_num,
          genre: new_song.genre,
          duration: new_song.duration,
          name: new_song.name,
          featured: true,
          feature_text: new_song.feature_text,
          image: base64_image
        }
      end

      let(:new_song) { FactoryBot.build(:song, :featured, track_num: song.track_num + 1) }

      it 'change song attributes' do
        put_request
        expect(json).to include_json(
          track_num: new_song.track_num,
          genre: new_song.genre,
          duration: new_song.duration,
          name: new_song.name,
          feature_text: new_song.feature_text
        )
        expect(json[:image_url]).to_not be_nil
      end
    end

    context 'when params have new artist to add' do
      let(:attributes) do
        {
          artists_attributes: [
            {
              name: artist.name,
              biography: artist.biography
            }
          ]
        }
      end

      let(:artist) { FactoryBot.build(:artist) }

      it 'creates a new artist linked to the song' do
        expect do
          put_request
        end.to change(Artist, :count).by(1)
        expect(Artist.last.songs).to include(song)
      end
    end

    context 'when params have artists to remove' do
      let(:attributes) do
        {
          artists_attributes: [
            {
              id: artist.id,
              _destroy: true
            }
          ]
        }
      end

      let!(:artist) do
        artist = FactoryBot.create(:artist)
        FactoryBot.create(:artist_song, song: song, artist: artist)
        artist
      end

      it 'remove the artist from the song' do
        expect do
          put_request
        end.to change { song.reload.artists.count }.by(-1)
      end

      it 'not remove the artist' do
        expect do
          put_request
        end.to_not change(Artist, :count)
      end
    end
  end
end
