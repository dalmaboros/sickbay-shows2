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
    erb :'/users/backdoor'
  end

  get '/contact' do
    erb :contact
  end

  get '/login' do
    erb :'/users/login'
  end

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/control'
      else
        redirect to '/backdoor'
      end
    else
      redirect to '/signup'
    end
  end

  # HELPERS

end
