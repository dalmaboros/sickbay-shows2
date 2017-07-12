class ArtistsController < ApplicationController
  # use Rack::Flash

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
        redirect to "artists/#{@artist.slug}"
      end
    else
      redirect to '/artists'
    end
  end

  # READ
  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :'/artists/show_artist'
  end

  # EDIT
  get '/artists/:slug/edit' do
    if logged_in?
      @artist = Artist.find_by_slug(params[:slug])
      erb :'/artists/edit_artist'
    else
      redirect to '/artists'
    end
  end

  patch '/artists/:slug' do
    if logged_in?
      @artist = Artist.find_by_slug(params[:slug])
      @artist.name = params[:name] if params[:name] != @artist.name
      @artist.save
      flash[:message] = "Successfully updated artist!"
      redirect to "/artists/#{@artist.slug}"
    else
      redirect to '/artists'
    end
  end

  # DELETE
  delete '/artists/:slug/delete' do
    @user = current_user
    @artist = Artist.find_by_slug(params[:slug])
    if logged_in? && @user.authenticate(params[:password])
      @artist.destroy
      flash[:message] = "BALEETED!"
      redirect to '/artists'
    else
      flash[:message] = "Incorrect password. Could not delete artist."
      redirect to "/artists/#{@artist.slug}/edit"
    end
  end

end
