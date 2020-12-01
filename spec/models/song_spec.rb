# frozen_string_literal: true

require 'rails_helper'

describe Song do
  let!(:song) { FactoryBot.create(:song) }
  subject { song }

  describe 'relationships' do
    it { is_expected.to belong_to(:album) }
    it { is_expected.to have_many(:artists).through(:artists_songs) }
  end

  describe 'validations' do
    context 'when song is not featured' do
      it { is_expected.to validate_absence_of(:feature_text) }
    end

    context 'when song is featured' do
      before { song.update(featured: true) }

      it { is_expected.not_to validate_absence_of(:feature_text) }
    end

    context '#unique_track_num' do
      context 'when there is another song with same track number in the album' do
        let(:new_song) { FactoryBot.build(:song, album: song.album, track_num: song.track_num) }

        specify do
          expect(new_song).not_to be_valid
        end
      end

      context 'when there is no other song with same track number in the album' do
        let(:new_song) { FactoryBot.build(:song, album: song.album, track_num: song.track_num + 1) }

        specify do
          expect(new_song).to be_valid
        end
      end
    end

    context '#unique_name' do
      context 'when there is another song with same name in the album' do
        let(:new_song) { FactoryBot.build(:song, album: song.album, name: song.name) }

        specify do
          expect(new_song).not_to be_valid
        end
      end

      context 'when there is no other song with same name in the album' do
        let(:new_song) { FactoryBot.build(:song, album: song.album) }

        specify do
          expect(new_song).to be_valid
        end
      end
    end

    context '#feature_image' do
      context 'when song is not featured and have an image' do
        let(:new_song) do
          FactoryBot.build(
            :song,
            image: Rack::Test::UploadedFile.new('public/sample_image.jpeg', 'image/jpeg')
          )
        end

        specify do
          expect(new_song).not_to be_valid
        end
      end
    end
  end
end
