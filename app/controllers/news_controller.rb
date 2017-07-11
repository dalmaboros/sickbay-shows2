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
    #
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
