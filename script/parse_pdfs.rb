require "pry"
require "json"
require "mechanize"

DOWNLOADS_DIR = File.expand_path("../tmp/reports")
URL = "http://employmentsummary.abaquestionnaire.org/"

agent = Mechanize.new
page = agent.get(URL)

year_selector = page.form.field_with(:name => 'ddlYear')
year = 2015
year_option = year_selector.options.find{|option| option.text == year.to_s}
year_option.select

school_selector = page.form.field_with(:name => 'ddlUniversity')
school_name = "YALE UNIVERSITY"
school_option = school_selector.options.find{|option| option.text == school_name}
school_option.select

form = page.forms.first
button = page.form.button_with(:value => "Generate Report")

response = agent.submit(form, button)
pdf_file = File.join(File.expand_path("../../tmp/reports", __FILE__), "my_report.pdf")

FileUtils.rm_rf(pdf_file)
File.open(pdf_file, 'wb') do |file|
  file << response.body
end
