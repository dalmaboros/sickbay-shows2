class NewsletterController < ApplicationController
  # CREATE
  get '/newsletter/signup' do
    erb :'/newsletter/signup'
  end

  post '/newsletter' do
    binding.pry
    Pony.mail to: params[:email],
              from: 'sickbay.party@gmail.com',
              subject: 'SUP',
              body: erb(:'newsletter/email')
  end
  # READ

  # UPDATE

  # DELETE

end
