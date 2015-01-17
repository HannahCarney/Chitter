require 'spec_helper'
require_relative 'helpers/session_helpers'

include SessionHelpers

feature "In order to use chitter as a maker I want to sign up to the service" do
  
  scenario "being able to sign up" do
    visit '/'
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome to Chitter, alice")
    expect(User.first.email).to eq("alice@example.com")
  end
end

feature "In order to use chitter as a maker I want to log in" do

   before(:each) do
    User.create(:username => "alice",
                :email => "alice@test.com",
                :password => 'test')
  end
    
  scenario "being able to sign in" do
    visit '/'
    sign_in('alice', 'test')
    expect(page).to have_content("Welcome back, alice")
  end

  feature "In order to avoid others using my account as a maker I want to log out" do
    
     before(:each) do
      User.create(:username => "alice",
                  :email => "alice@test.com",
                  :password => 'test')
    end

    scenario "being able to log out" do
      visit '/'
      sign_in('alice', 'test')
      sign_out
      expect(page).to have_content("You are now logged out")
    end


  end

  feature "In order to let people know what I am doing as a maker I want to post a message (peep) to chitter" do
  
    scenario "making a peep" do
      visit '/'
      expect(page).to have_content("Post a new peep!")
      fill_in "message", :with => "This is a peep!"
      click_button "Submit"
      expect(page).to have_content("This is a peep!")
    end

  end

  feature "In order to see what people have to say as a maker I want to see all peeps in chronological order" do

    before(:each) do
      Peep.create(:message => "First Peep")
      Peep.create(:message => "Second Peep")
    end

    scenario "See all peeps" do
      visit ('/peep')
      expect(page).to have_content("First Peep")
      expect(page).to have_content("Second Peep")
    end 
  end
end