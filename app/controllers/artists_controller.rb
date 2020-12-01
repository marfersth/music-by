# frozen_string_literal: true

class ArtistsController < ApplicationController
  def index
    artists = Artist.all
    render json: artists, each_serializer: Artist::MinimalSerializer
  end

  def show
    render json: artist, serializer: Artist::WithRelationsSerializer
  end

  def update
    artist.update!(artist_params)
    render json: artist, serializer: Artist::WithRelationsSerializer
  end

  def create
    artist = Artist.create!(artist_params)
    render json: artist, serializer: Artist::WithRelationsSerializer
  end

  def destroy
    artist.destroy!
    head :no_content
  end

  private

  def artist_params
    params.require(:artist).permit(:biography, :name,
                                   albums_attributes: %i[id name year _destroy])
  end

  def artist
    @artist ||= ::Artist.find(params[:id])
  end
end
