require 'sinatra'
require 'json'
require 'base64'

# OpenKore Web Service
class OpenKoreAPI < Sinatra::Base
  enable :logging

  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [ENV['USERNAME'], ENV['PASSWORD']]
    end
  end

  get '/?' do
    'OpenKore web service is up and running at /api/v1'
  end

  get '/ping' do
    'pong'
  end

  get '/api/v1/?' do
    "Version 1.0 for our api"
  end
end
