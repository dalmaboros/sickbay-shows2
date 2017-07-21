class ApplicationController < Sinatra::Base
  use Rack::Flash

  # CONFIGURE
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  # GENERAL ROUTES
  get '/' do
    @shows = Show.where("date >= ?", Date.today).order(:date)
    erb :'/shows/shows_index'
  end

  get '/backdoor' do
    if !logged_in?
      erb :backdoor
    else
      redirect to '/dashboard'
    end
  end

  get '/dashboard' do
    if logged_in?
      erb :dashboard
    else
      redirect to '/'
    end
  end

  not_found do
    status 404
    redirect to '/'
  end

  # HELPERS
  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

end
