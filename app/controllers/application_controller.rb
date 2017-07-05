class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/shows' do
    @shows = Show.all
    erb :'/shows/shows_index'
  end

  get '/shows/new' do
    erb :'/shows/create'
  end

  post '/shows/new' do
    binding.pry
  end

  get '/shows/archive' do
    erb :'/shows/archive'
  end

end
