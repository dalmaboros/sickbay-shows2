class ArtistsController < ApplicationController

  get '/artists' do
    @artists = Artist.order("lower(name)")
    erb :'/artists/artists_index'
  end

  # CREATE
  get '/artists/new' do
    if logged_in?
      erb :'/artists/create_artist'
    else
      redirect to '/artists'
    end
  end

  post '/artists/new' do
    if logged_in?
      if Artist.find_by(name: params[:name])
        flash[:message] = "Artist already exists."
        redirect to "artists/new"
      else
        @artist = Artist.create(name: params[:name])
        flash[:message] = "Successfully created artist!"
        redirect to "artists/#{@artist.id}"
      end
    else
      redirect to '/artists'
    end
  end

  # READ
  get '/artists/:id' do
    @artist = Artist.find_by(id: params[:id])
    erb :'/artists/show_artist'
  end

  # EDIT
  get '/artists/:id/edit' do
    if logged_in?
      @artist = Artist.find_by(id: params[:id])
      erb :'/artists/edit_artist'
    else
      redirect to '/artists'
    end
  end

  patch '/artists/:id' do
    if logged_in?
      @artist = Artist.find_by(id: params[:id])
      @artist.name = params[:name] if params[:name] != @artist.name
      @artist.save
      flash[:message] = "Successfully updated artist!"
      redirect to "/artists/#{@artist.id}"
    else
      redirect to '/artists'
    end
  end

  # DELETE
  delete '/artists/:id/delete' do
    @user = current_user
    @artist = Artist.find_by(id: params[:id])
    if logged_in? && @user.authenticate(params[:password])
      @artist.destroy
      redirect to '/artists'
    else
      redirect to "/artists/#{@artist.id}/edit"
    end
  end
end
