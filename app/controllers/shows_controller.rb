class ShowsController < ApplicationController

  # CREATE
  get '/shows/new' do
    if logged_in?
      @show = Show.new
      erb :'/shows/create_show'
    else
      redirect to '/shows'
    end
  end

  post '/shows' do
    if logged_in?
      validate_show
      @show = Show.new
      binding.pry

      if @errors.empty?
        @show.date = params[:date]
        @show.venue = Venue.find_or_create_by(name: params[:venue])
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
        # redirect to "/login"
      else
        erb :'/shows/create_show'
      end
    else
      erb :'/shows'
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
      binding.pry
      erb :'/shows/edit_show'
    else
      redirect to '/shows'
    end
  end

  patch '/shows/:id' do
    if logged_in?
      validate_show
      @show = Show.find_by(id: params[:id])
      binding.pry
      if @errors.empty?
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
        erb :'/shows/edit_show'
      end
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

  private

  def validate_show
    @errors = {}

    if params[:date].empty?
      @errors[:date] = "Date can't be empty!"
    elsif !/^\d{4}-\d{2}-\d{2}$/.match(params[:date])
      @errors[:date] = "Date format must be yyyy-mm-dd!"
    end

    if params[:venue] && params[:venue].empty?
      @errors[:venue] = "Venue can't be empty!"
    end

    if params[:artists].all? {|artist| artist == "" }
      @errors[:artists] = "Must have at least one artist!"
    end
  end

end
