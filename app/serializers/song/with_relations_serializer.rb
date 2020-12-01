# frozen_string_literal: true

class Song::WithRelationsSerializer < ::Song::MinimalSerializer
  belongs_to :album, serializer: ::Album::MinimalSerializer
  has_many :artists, serializer: ::Artist::MinimalSerializer
end
