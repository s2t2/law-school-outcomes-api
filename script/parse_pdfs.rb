require "pry"
require "json"
require "capybara"
require 'capybara/poltergeist' # require "capybara-webkit" # require "selenium-webdriver"
require "law_school_outcomes"

URL = "http://employmentsummary.abaquestionnaire.org/"

session = Capybara::Session.new(:poltergeist) # :webkit :selenium

session.visit(URL)

puts "VISITED #{session.current_url}"

# click on select with id="ddlUniversity" and name="ddlUniversity"
# ... and loop through each of the available options

# click on select with id="ddlYear" and name="ddlYear"
# ... and choose 2015

# click button with id="btnSubmit"
# session.click_button 'Generate Report'

# session.save_and_open_page
