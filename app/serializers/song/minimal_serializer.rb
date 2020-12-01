# frozen_string_literal: true

class Song::MinimalSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :track_num, :genre, :duration, :name, :created_at, :updated_at

  attribute :feature_text, if: -> { object.featured }
  attribute :image_url, if: -> { object.featured }
  def image_url
    return if object.image.blank?

    rails_blob_path(object.image, only_path: true)
  end
end
