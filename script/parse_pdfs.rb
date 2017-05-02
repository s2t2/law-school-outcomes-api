require "pry"
require "mechanize"
require "pdf-reader"

URL = "http://employmentsummary.abaquestionnaire.org/"

agent = Mechanize.new
agent.pluggable_parser.pdf = Mechanize::File # ... not sure whether to use Mechanize::Download or Mechanize::File
page = agent.get(URL)

#
# SELECT YEAR
#

year = 2015
year_selector = page.form.field_with(:name => 'ddlYear')
year_option = year_selector.options.find{|option| option.text == year.to_s}
year_option.select

#
# SELECT SCHOOL
#

school_name = ["YALE UNIVERSITY", "CALIFORNIA-BERKELEY, UNIVERSITY OF", "CARDOZO SCHOOL OF LAW", "BOSTON COLLEGE", "BOSTON UNIVERSITY"].sample
school_selector = page.form.field_with(:name => 'ddlUniversity')
school_option = school_selector.options.find{|option| option.text == school_name}
school_option.select

#
# SUBMIT FORM TO REVEAL PDF FILE CONTENTS
#

form = page.forms.first
button = page.form.button_with(:value => "Generate Report")
response = agent.submit(form, button) #> Mechanize::File or Mechanize::Download

#
# DOWNLOAD PDF FILE TO LATER MANUALLY OPEN IT AND DOUBLE-CHECK IT LOOKS GOOD!
#

local_file = File.join(File.expand_path("../../tmp", __FILE__), "my_report.pdf") # only if unable to use tempfile

FileUtils.rm_rf(local_file)

response.save(local_file)

#
# PARSE PDF FILE
#
# upon further inspection, the file gets saved with a bunch of HTML-looking stuff after the ending "EOF" marker

begin
  reader = PDF::Reader.new(local_file) #> PDF::Reader::MalformedPDFError: PDF does not contain EOF marker
  puts "READING PDF WITH #{reader.pages.count} PAGES"
rescue PDF::Reader::MalformedPDFError
  binding.pry

  # some stuff I tried to fix the issue but it's not working...
  #content = File.open(local_file, 'rb') { |io| io.read }
  #content.length #> 150633
  #pdf_content = content.split("%%EOF").first
  #pdf_content.length #> 100393
  #reader = PDF::Reader.new(pdf_content) #> ArgumentError: string contains null byte
  #clean_content = pdf_content.scrub
  #reader = PDF::Reader.new(clean_content) #> ArgumentError: string contains null byte
end
