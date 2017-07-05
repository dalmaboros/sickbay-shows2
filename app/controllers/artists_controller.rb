class ArtistsController < ApplicationController

  get '/artists' do
    @artists = Artist.order(:name)
    erb :'/artists/artists_index'
  end

  get '/artists/:id' do
    @artist = Artist.find_by(id: params[:id])
    erb :'/artists/show_artist'
  end

  # EDIT
  get '/artists/:id/edit' do
    @artist = Artist.find_by(id: params[:id])
    erb :'/artists/edit_artist'
  end

  patch '/artists/:id' do
    @artist = Artist.find_by(id: params[:id])
    # binding.pry
    @artist.name = params[:name] if params[:name] != @artist.name
    @artist.save
    redirect to "/artists/#{@artist.id}"
  end

  # DELETE
  delete '/artists/:id/delete' do
    @artist = Artist.find_by(id: params[:id])
    @artist.destroy
    redirect to '/artists'
  end
end
