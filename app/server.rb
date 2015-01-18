require 'data_mapper'
require 'sinatra'
require 'rack-flash'
require 'sinatra/partial'

require_relative './models/peep'

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