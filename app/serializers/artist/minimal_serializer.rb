# frozen_string_literal: true

class Artist::MinimalSerializer < ActiveModel::Serializer
  attributes :id, :biography, :name, :created_at, :updated_at
end
