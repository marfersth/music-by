# frozen_string_literal: true

require 'rails_helper'

describe Artist do
  let!(:artist) { FactoryBot.create(:artist) }
  subject { artist }

  describe 'relationships' do
    it { is_expected.to have_many(:songs).through(:artists_songs) }
    it { is_expected.to have_many(:albums).through(:albums_artists) }
  end
end
