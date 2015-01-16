require 'spec_helper'

feature "In order to use chitter as a maker I want to sign up to the service" do
  
  scenario "when being a new user visiting the site" do
    visit '/'
    expect(page).to have_content("Welcome to Chitter")
    expect{ sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, alice@example.com")
    expect(User.first.email).to eq("alice@example.com")
  end

  # scenario "with a password that doesn't match" do

  # end

  # scenario "with an email that is already registered" do
  # end
  
  
end