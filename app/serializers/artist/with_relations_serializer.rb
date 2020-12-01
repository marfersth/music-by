# frozen_string_literal: true

class Artist::WithRelationsSerializer < ::Artist::MinimalSerializer
  has_many :albums, serializer: ::Album::MinimalSerializer
  has_many :songs, serializer: ::Song::MinimalSerializer
end
