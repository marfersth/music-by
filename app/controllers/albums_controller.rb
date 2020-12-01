# frozen_string_literal: true

class AlbumsController < ApplicationController
  def index
    albums = Album.all
    render json: albums, each_serializer: Album::MinimalSerializer
  end

  def show
    render json: album, serializer: Album::WithRelationsSerializer
  end

  def update
    album.update!(album_params)
    render json: album, serializer: Album::WithRelationsSerializer
  end

  def create
    album = Album.create!(album_params)
    render json: album, serializer: Album::WithRelationsSerializer
  end

  def destroy
    album.destroy!
    head :no_content
  end

  private

  def album_params
    params.require(:album).permit(:year, :name,
                                  songs_attributes: %i[id track_num genre duration name
                                                       featured feature_text _destroy])
  end

  def album
    @album ||= ::Album.find(params[:id])
  end
end
