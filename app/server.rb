require 'data_mapper'
require 'sinatra'
require 'rack-flash'
require 'sinatra/partial'

require_relative './models/peep'
require_relative './models/tag'
require_relative './models/user'
require_relative './helpers/application_helper'

use Rack::MethodOverride
enable :sessions
set :session_secret, 'super secret'


env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './app/models/peep'

DataMapper.finalize

DataMapper.auto_upgrade!


get '/' do
  @peeps = Peep.all
  erb :index
end

post '/peeps' do
  message = params[:message]
  owner = params[:owner]
  tags = params[:tags].split(" ").map do |tag|
    Tag.first_or_create(:text => tag)
  end
  Peep.create(:message => message, :owner => owner, :tags => tags)
  redirect to('/')
end

get '/tags/:text' do
  tag = Tag.first(:text => params[:text])
  @peeps = tag ? tag.peeps : []
  erb :index
end

get '/users/new' do
  erb :"users/new"
end

post '/users' do
  user = User.create(:email => params[:email],
              :password => params[:password],
              :password_confirmation => params[:password_confirmation])
  session[:user_id] = user.id 
  redirect to('/')
end







