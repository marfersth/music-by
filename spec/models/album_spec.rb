# frozen_string_literal: true

require 'rails_helper'

describe Album do
  let!(:album) { FactoryBot.create(:album) }
  subject { album }

  describe 'relationships' do
    it { is_expected.to have_many(:artists).through(:albums_artists) }
    it { is_expected.to have_many(:songs) }
  end
end
