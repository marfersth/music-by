# frozen_string_literal: true

require 'rails_helper'
include Rails.application.routes.url_helpers

RSpec.describe 'GET /songs', type: :request do
  subject(:get_request) do
    get '/songs'
  end

  context 'when there are no songs' do
    include_examples 'empty response'
  end

  context 'when there are songs' do
    let!(:featured_song) { FactoryBot.create(:song, :featured) }
    let!(:not_featured_song) { FactoryBot.create(:song) }

    it 'return all songs' do
      get_request
      json_response = JSON.parse(response.body)
      expect(json_response.count).to eq(2)
    end

    it 'return not featured song data' do
      get_request
      json_response = JSON.parse(response.body)
      json_response.each do |song_data|
        song = Song.find(song_data['id'])
        expect(song_data.with_indifferent_access).to include_json(
          id: song.id,
          track_num: song.track_num,
          genre: song.genre,
          duration: song.duration,
          name: song.name
        )
      end
    end

    it 'return featured song data' do
      get_request
      json_response = JSON.parse(response.body)
      json_response.each do |song_data|
        song = Song.find(song_data['id'])
        if song.featured
          expect(song_data.with_indifferent_access).to include_json(
            feature_text: song.feature_text,
            image_url: rails_blob_path(song.image, only_path: true)
          )
        else
          expect(song_data.with_indifferent_access).to_not include(
            :featur_text, :image_url
          )
        end
      end
    end
  end
end
