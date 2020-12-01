# frozen_string_literal: true

class Album::MinimalSerializer < ActiveModel::Serializer
  attributes :id, :year, :name, :created_at, :updated_at
end
