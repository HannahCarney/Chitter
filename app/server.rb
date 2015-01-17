require 'sinatra/base'
require 'rack-flash'
require 'pony'
require 'data_mapper'

require_relative 'helpers/currentuser'
require_relative 'data_mapper_setup'

DataMapper.auto_upgrade!

class Chitter < Sinatra::Base

  helpers do

   def send_message
    Pony.mail({
     :from => params[:name] + "<" + params[:email] + ">",
     :to => 'hannahcarneyart@gmail.com',
     :subject => params[:name] + " has contacted you",
     :body => params[:message],
     :via => :smtp,
     :via_options => {
       :address              => 'smtp.gmail.com',
       :port                 => '587',
       :enable_starttls_auto => true,
       :user_name            => 'hannahcarneyart@gmail.com',
       :password             => '07089000',
       :authentication       => :plain,
       :domain => 'localhost.localdomain'
      }
     })
  end
end


  enable :sessions
  set :sessions_secret, 'super secret'
  use Rack::Flash
  use Rack::MethodOverride

  get '/' do
    puts "home"
    erb :index
  end

  get '/about' do
    @title = "All About this Website"
    erb :about
  end

  get '/contact' do
    @title = "Contact Chitter"
    erb :contact
  end

  post '/contact' do
    send_message
    flash[:notice] = "Thank you for your message. We'll be in touch soon."
    redirect to ('/')
  end

  get '/users/new' do
    @title = "Create a New User"
    @user = User.new
    erb :signup
  end

  post '/users' do
    @user = User.new(:username => params[:username],
                     :email => params[:email],
                     :password => params[:password])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Chitter, #{@user.username}"
      redirect ('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :signup
    end
  end

  get '/sessions/new' do
    @title = "Sign in"
    erb :signin
  end

  post '/sessions' do
    username, password = params[:username], params[:password]
    @user = User.authenticate(username, password)
    if @user
     session[:user_id] = @user.id
     flash[:notice] = "Welcome back, #{@user.username}"
     redirect ('/')
    else 
      flash[:errors] = ["Sorry, wrong username or password"]
      erb :signin
   end
  end

  get '/sessions/logout' do
    if session[:user_id]
      session[:user_id] = nil
      flash[:notice] = "You are now logged out"
      redirect to('/')
    else 
      flash[:notice] = "You are not logged in"
      redirect to ('/')
    end
  end

  not_found do
    puts "not found"
    erb :not_found
  end

 run! if app_file == $0

end
