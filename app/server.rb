require 'sinatra/base'
require 'rack-flash'
require 'pony'
require 'data_mapper'

require_relative 'helpers/currentuser'
require_relative 'data_mapper_setup'

DataMapper.auto_upgrade!

class Chitter < Sinatra::Base

  helpers CurrentUser

  enable :sessions
  set :sessions_secret, 'super secret'
  use Rack::Flash
  use Rack::MethodOverride

  get '/' do
    puts "home"
    erb :index
  end

  get '/about' do
    erb :about
  end

  get '/contact' do
    erb :contact
  end

  get '/users/new' do
    @user = User.new
    erb :signup
  end

  post '/users' do
    @user = User.new(:username => params[:username],
                     :email => params[:email],
                     :password => params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect ('/')
    end
  end

  not_found do
    puts "not found"
    erb :not_found
  end

 run! if app_file == $0

end
