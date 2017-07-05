class ArtistsController < ApplicationController

  get '/artists' do
    @artists = Artist.order(:name)
    erb :'/artists/artists_index'
  end

  get '/artists/:id' do
    @artist = Artist.find_by(id: params[:id])
    erb :'/artists/show_artist'
  end
end
