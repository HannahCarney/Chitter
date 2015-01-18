require 'pony'

module CurrentUser
 
  def send_message
    Pony.mail({
     :from => params[:name] + "<" + params[:email] + ">",
     :to => KEY1,
     :subject => params[:name] + " has contacted you",
     :body => params[:message],
     :via => :smtp,
     :via_options => {
       :address              => 'smtp.gmail.com',
       :port                 => '587',
       :enable_starttls_auto => true,
       :user_name            => KEY1,
       :password             => KEY2,
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
      flash[:notice] = "You need to be logged in to do that"
      redirect ('/')
    end
  end

  def right_user?
      Peep.get(params[:id]).username == User.get(session[:user_id]).username
  end

  def correct_user!
    unless right_user?
      flash[:notice] = "You can't do this to someone else's peep"
      redirect ('/')
    end
  end



end

