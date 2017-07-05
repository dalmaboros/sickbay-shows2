class ApplicationController < Sinatra::Base

  # CONFIGURE
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  # ROUTES
  get '/' do
    erb :index
  end

  get '/shows' do
    @shows = Show.all
    erb :'/shows/shows_index'
  end

  # CREATE

  get '/shows/new' do
    @style = polyfill_css
    erb :'/shows/create'
  end

  post '/shows/new' do
    # binding.pry
    @venue = Venue.find_or_create_by(name: params[:venue])
    @show = Show.new(date: params[:date], venue: @venue)
    @show.url = params[:url] if params[:url] != ""

    # add all artists if not empty
    params[:artists].each do |artist|
      if artist != ""
        artist_object = Artist.find_or_create_by(name: artist)
        @show.artists << artist_object
      end
    end
    
    @show.save
    redirect to "/shows/#{@show.id}"
  end

  # READ
  get '/shows/:id' do
    @show = Show.find_by(id: params[:id])
    erb :'/shows/show_show'
  end

  get '/shows/archive' do
    erb :'/shows/archive'
  end

  # HELPERS
  helpers do
    def polyfill_css
      <<~HTML
      <style>
            .datalist-polyfill {
            	list-style: none;
            	display: none;
            	background: white;
            	box-shadow: 0 2px 2px #999;
            	position: absolute;
            	left: 0;
            	top: 0;
            	margin: 0;
            	padding: 0;
            	max-height: 300px;
            	overflow-y: auto;
            }

            .datalist-polyfill:empty {
            	display: none !important;
            }

            .datalist-polyfill > li {
                padding: 3px;
                font: 13px "Lucida Grande", Sans-Serif;
            }

            .datalist-polyfill__active {
                background: #3875d7;
                color: white;
            }
          </style>
      HTML
    end # END polyfill_css

  end # END helpers

end
