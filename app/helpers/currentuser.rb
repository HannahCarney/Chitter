require 'pony'
require_relative '../secret_files'

module CurrentUser
 
  def send_message
    Pony.mail({
     :from => params[:name] + "<" + params[:email] + ">",
     :to => $email,
     :subject => params[:name] + " has contacted you",
     :body => params[:message],
     :via => :smtp,
     :via_options => {
       :address              => 'smtp.gmail.com',
       :port                 => '587',
       :enable_starttls_auto => true,
       :user_name            => $email,
       :password             => $password,
       :authentication       => :plain,
       :domain => 'localhost.localdomain'
      }
     })
  end 

  def email_valid(email)
    return email.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]\.)[a-zA-Z]{2,4}/)
  end

  def authorized?
    session[:user_id]
  end

  def protected!
    unless authorized?
      flash[:notice] = "You need to be logged in to post a peep"
      redirect ('/')
    end
  end


end

