require "capybara"
require 'capybara/poltergeist'

class MySession < Capybara::Session
  URL = "http://employmentsummary.abaquestionnaire.org/"

  # @param [symbol] driver A web driver like: :poltergeist OR :webkit OR :selenium
  def initialize(driver = :poltergeist)
    super(driver)
    visit_page
  end

  def visit_page
    visit(URL)
    puts "VISITING #{current_url}"
    puts "HEADERS: #{response_headers}"
  end

  def file
    File.join(Dir.pwd, "test/capybara-saved-page.html")
  end

  def open_page
    FileUtils.rm_rf(file)
    save_and_open_page(file)
  end
end
