class ApplicationController < Sinatra::Base
  # set :session_secret, "my_application_secret"
  # set :views, Proc.new { File.join(root, "../views/") }
  # set :public_folder, Proc.new { File.join(root, "static") }

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

  get '/backdoor' do
    erb :backdoor
  end

  get '/contact' do
    erb :contact
  end

  get '/login' do
    erb :login
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/tweets'
      else
        redirect to '/signup'
      end
    else
      redirect to '/signup'
    end
  end

  # HELPERS

end
