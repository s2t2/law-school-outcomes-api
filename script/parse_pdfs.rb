require "pry"
require "json"
require "capybara"
require 'capybara/poltergeist' # require "capybara-webkit" # require "selenium-webdriver"
require "law_school_outcomes"

class MySession < Capybara::Session
  URL = "http://employmentsummary.abaquestionnaire.org/"

  # @param [symbol] driver A web driver like: :poltergeist OR :webkit OR :selenium
  def initialize(driver = :poltergeist)
    super(driver)
  end

  def visit_page
    visit(URL)
    puts "VISITING #{current_url}"
  end

  def inspect_page
    file = File.join(Dir.pwd, "test/capybara-saved-page.html")
    FileUtils.rm_rf(file)
    save_and_open_page(file)
  end
end

session = MySession.new

session.visit_page

# TODO: loop through each of the available options
# school_selector = session.find("#ddlUniversity")
# options = school_selector.all("option")

#
# click on select with id="ddlUniversity" and name="ddlUniversity"
# ... and choose the relevant university
#

session.select('YALE UNIVERSITY', from: 'ddlUniversity')
school_id = session.find("#ddlUniversity").value
puts "SCHOOL: #{school_id}"

#
# click on select with id="ddlYear" and name="ddlYear"
# ... and choose 2015
#

year = session.find("#ddlYear").value
puts "YEAR: #{year}"

#
# click button with id="btnSubmit"
# session.click_button 'Generate Report'
#
