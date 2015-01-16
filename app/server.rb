require 'sinatra/base'
require 'rack-flash'
require 'pony'
require 'data_mapper'

require_relative 'data_mapper_setup'

class Chitter < Sinatra::Base
  
  enable :sessions
  set :sessions_secret, 'super secret'
  use Rack::Flash
  use Rack::MethodOverride

  get '/' do
    puts "home"
    erb :index
  end

  not_found do
    puts "not found"
    erb :not_found
  end
 run! if app_file == $0

end
