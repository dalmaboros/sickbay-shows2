class ArtistsController < ApplicationController

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
      validate_artist
      binding.pry
      if @errors.empty?
        @artist = Artist.create(name: params[:name])
        flash[:message] = "Successfully created artist!"
        redirect to "artists/#{@artist.slug}"
      else
        erb :'/artists/create_artist'
      end
    else
      redirect to '/artists'
    end
  end

  # READ
  get '/artists' do
    @artists = Artist.order("lower(name)")
    erb :'/artists/artists_index'
  end

  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :'/artists/show_artist'
  end

  # UPDATE
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
      validate_artist
      @artist = Artist.find_by_slug(params[:slug])
      if @errors.empty?
        @artist.name = params[:name]
        @artist.save
        flash[:message] = "Successfully updated artist!"
        redirect to "/artists/#{@artist.slug}"
      else
        erb :'/artists/edit_artist'
      end
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

  private

  def validate_artist
    @errors = {}

    if params[:name].empty?
      @errors[:artist] = "Artist can't be empty!"
    elsif Artist.find_by(name: params[:name]) && Artist.find_by(name: params[:name]) != Artist.find_by_slug(params[:slug])
      @errors[:artist] = "Artist already exists!"
    end
  end

end
