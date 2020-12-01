# frozen_string_literal: true

class Song < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64

  belongs_to :album
  has_many :artists_songs, class_name: 'ArtistsSongs', dependent: :destroy
  has_many :artists, through: :artists_songs, inverse_of: :songs
  has_one_base64_attached :image

  accepts_nested_attributes_for :artists, allow_destroy: true

  validates :feature_text, absence: true, unless: :featured
  validate :unique_track_num, :unique_name, :feature_image

  private

  def unique_track_num
    song_with_same_track = Song.where(album_id: album.try(:id), track_num: track_num).where.not(id: id)
    return if song_with_same_track.empty?

    errors.add(:track_num, 'track number need to be unique in album')
    throw(:abort)
  end

  def unique_name
    song_with_same_name = Song.where(album_id: album.try(:id), name: name).where.not(id: id)
    return if song_with_same_name.empty?

    errors.add(:name, 'track name need to be unique in album')
    throw(:abort)
  end

  def feature_image
    return if featured || image.blank?

    errors.add(:name, 'image only allowed if the song is featured')
    throw(:abort)
  end
end
