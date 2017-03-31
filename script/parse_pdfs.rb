require "pry"
require "json"
require "capybara"
require "capybara-webkit"

DOWNLOADS_DIR = File.expand_path("../tmp/reports")

Capybara::Webkit.configure do |config|
  config.debug = true # Enable debug mode. Prints a log of everything the driver is doing.
  config.allow_unknown_urls # Allow pages to make requests to any URL without issuing a warning.
  config.timeout = 5 # Timeout if requests take longer than 5 seconds
  config.skip_image_loading # Don't load images
  config.raise_javascript_errors = true # Raise JavaScript errors as exceptions
end

Capybara.javascript_driver = :webkit

session = Capybara::Session.new(:webkit)

session.visit("http://employmentsummary.abaquestionnaire.org/")
session.select('YALE UNIVERSITY', from: 'ddlUniversity')
# session.click_button('Generate Report')

#Capybara.register_driver :chrome do |app|
#  profile = Selenium::WebDriver::Chrome::Profile.new
#  profile["download.default_directory"] = DOWNLOADS_DIR
#  Capybara::Selenium::Driver.new(app, :browser => :chrome, :profile => profile)
#end

#Capybara.default_driver = Capybara.javascript_driver = :chrome
