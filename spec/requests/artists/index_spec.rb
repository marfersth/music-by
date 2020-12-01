# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /artists', type: :request do
  subject(:get_request) do
    get '/artists'
  end

  context 'when there are no artists' do
    include_examples 'empty response'
  end

  context 'when there are artists' do
    before { FactoryBot.create_list(:artist, 2) }

    it 'return all albums' do
      get_request
      json_response = JSON.parse(response.body)
      expect(json_response.count).to eq(2)
    end

    it 'return artists attributes' do
      get_request
      json_response = JSON.parse(response.body)
      json_response.each do |artist_data|
        artist = Artist.find(artist_data['id'])
        expect(artist_data.with_indifferent_access).to include_json(
          id: artist.id,
          biography: artist.biography,
          name: artist.name
        )
      end
    end
  end
end
