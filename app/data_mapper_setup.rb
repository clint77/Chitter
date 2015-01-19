require 'dm-postgres-adapter'
require_relative './models/tag'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './app/models/peep'

DataMapper.finalize
DataMapper.auto_upgrade!