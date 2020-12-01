# frozen_string_literal: true

class SongsController < ApplicationController
  def index
    songs = Song.all
    render json: songs, each_serializer: Song::MinimalSerializer
  end

  def show
    render json: song, serializer: Song::WithRelationsSerializer
  end

  def update
    song.update!(song_params)
    song.image.attach(data: params[:song][:image]) if params[:song][:image]
    render json: song, serializer: Song::WithRelationsSerializer
  end

  def create
    song = Song.create!(song_params)
    song.image.attach(data: params[:song][:image])
    render json: song, serializer: Song::WithRelationsSerializer
  end

  def destroy
    song.destroy!
    head :no_content
  end

  private

  def song_params
    params.require(:song).permit(:track_num, :genre, :duration, :name, :featured, :feature_text, :album_id,
                                 artists_attributes: %i[id name biography _destroy],
                                 artists_songs_attributes: %i[id _destroy])
  end

  def song
    @song ||= ::Song.find(params[:id])
  end
end
