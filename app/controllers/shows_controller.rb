class ShowsController < ApplicationController

  # CREATE
  get '/shows/new' do
    if logged_in?
      erb :'/shows/create_show'
    else
      redirect to '/shows'
    end
  end

  post '/shows/new' do
    if logged_in?
      venue = Venue.find_or_create_by(name: params[:venue])
      @show = Show.new(date: params[:date], venue: venue)
      @show.url = params[:url] if !params[:url].empty?

      # add all artists if not empty
      params[:artists].each do |artist|
        if !artist.empty?
          @show.artists << Artist.find_or_create_by(name: artist)
        end
      end

      @show.save
      flash[:message] = "Successfully created show!"
      redirect to "/shows/#{@show.id}"
    else
      redirect to "/shows"
    end
  end

  # READ
  get '/shows' do
    @shows = Show.where("date >= ?", Date.today).order(:date)
    erb :'/shows/shows_index'
  end

  get '/shows/archive' do
    @shows = Show.where("date < ?", Date.today).order(:date).reverse
    erb :'/shows/shows_index'
  end

  get '/shows/all' do
    @shows = Show.order(:date).reverse
    erb :'/shows/shows_index'
  end

  get '/shows/:id' do
    if logged_in?
      @show = Show.find_by(id: params[:id])
      if @show.nil?
        erb :'/shows/not_found'
      else
        erb :'/shows/show_show'
      end
    else
      redirect to '/shows'
    end
  end

  # UPDATE
  get '/shows/:id/edit' do
    if logged_in?
      @show = Show.find_by(id: params[:id])
      erb :'/shows/edit_show'
    else
      redirect to '/shows'
    end
  end

  patch '/shows/:id' do
    if logged_in?
      @show = Show.find_by(id: params[:id])
      @show.date = params[:date] if params[:date] != @show.date
      @show.venue = Venue.find_or_create_by(name: params[:venue]) if params[:venue] != @show.venue.name
      @show.url = params[:url] if params[:url] != @show.url && !params[:url].empty?

      @show.artists.clear
      params[:artists].each do |artist|
        if !artist.empty?
          artist_object = Artist.find_or_create_by(name: artist)
          @show.artists << artist_object
        end
      end

      @show.save
      flash[:message] = "Successfully updated show!"
      redirect to "/shows/#{@show.id}"
    else
      redirect to '/shows'
    end
  end

  # DELETE
  delete '/shows/:id/delete' do
    @user = current_user
    @show = Show.find_by(id: params[:id])
    if logged_in? && @user.authenticate(params[:password])
      @show.destroy
      flash[:message] = "BALEETED!"
      redirect to '/shows'
    else
      flash[:message] = "Incorrect password. Could not delete show."
      redirect to "/shows/#{@show.id}/edit"
    end
  end
end
