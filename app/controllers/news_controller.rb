class NewsController < ApplicationController

  get '/news' do
    @news = News.all
    erb :'/news/news_index'
  end

  # CREATE
  get '/news/new' do
    if logged_in?
      erb :'/news/create_news'
    else
      redirect to '/news'
    end
  end

  post '/news/new' do
    if logged_in?
      if News.find_by(date: params[:date], content: params[:content])
        flash[:message] = "News item already exists."
        redirect to "/news/new"
      else
        @news = News.create(date: params[:date], content: params[:content])
        flash[:message] = "Successfully created news item!"
        redirect to "/news"
      end
    else
      redirect to '/artists'
    end
  end

  # UPDATE
  get '/news/:id/edit' do
    if logged_in?
      erb :'/news/edit_news'
    else
      redirect to '/news'
    end
  end

  patch '/news/:id/edit' do
    #
  end

  delete '/news/:id/delete' do
    #
  end

end
