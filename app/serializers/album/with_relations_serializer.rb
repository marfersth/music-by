# frozen_string_literal: true

class Album::WithRelationsSerializer < ::Album::MinimalSerializer
  has_many :artists, each_serializer: ::Artist::MinimalSerializer
  has_many :songs, serializer: ::Song::MinimalSerializer
end
