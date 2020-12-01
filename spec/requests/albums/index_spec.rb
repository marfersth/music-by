# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /albums', type: :request do
  subject(:get_request) do
    get '/albums'
  end

  context 'when there are no albums' do
    include_examples 'empty response'
  end

  context 'when there are albums' do
    before { FactoryBot.create_list(:album, 2) }

    it 'return all albums' do
      get_request
      json_response = JSON.parse(response.body)
      expect(json_response.count).to eq(2)
    end

    it 'return albums attributes' do
      get_request
      json_response = JSON.parse(response.body)
      json_response.each do |album_data|
        album = Album.find(album_data['id'])
        expect(album_data.with_indifferent_access).to include_json(
          id: album.id,
          year: album.year,
          name: album.name
        )
      end
    end
  end
end
