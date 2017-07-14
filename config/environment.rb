ENV['SINATRA_ENV'] ||= "development"

require 'rack-flash'
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require_all 'app'
