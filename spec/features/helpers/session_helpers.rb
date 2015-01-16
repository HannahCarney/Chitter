module SessionHelpers 

 def sign_up(username = "alice",
             email = "alice@example.com",
             password = "oranges!")
      visit '/users/new'
      expect(page.status_code).to eq(200)
      fill_in :username, :with => username
      fill_in :email, :with => email
      fill_in :password, :with => password
      click_button "Sign up"
    end

  def sign_in(username, password)
      visit '/sessions/new'
      expect(page.status_code).to eq(200)
      fill_in 'username', :with => username
      fill_in 'password', :with => password
      click_button "Sign in"
  end

end