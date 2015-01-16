require 'sinatra/base'
require 'rack-flash'
require 'pony'
require 'data_mapper'

env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/link'

DataMapper.finalize

DataMapper.auto_upgrade!

class Chitter < Sinatra::Base

  get '/' do
    erb :index
  end



end
