require 'data_mapper'
require 'sinatra'
require 'rack-flash'
require 'sinatra/partial'

require_relative './models/peep'
require_relative './models/tag'

use Rack::MethodOverride


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


