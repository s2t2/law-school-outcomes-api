require "pry"
require "json"
require "mechanize"
require "pdf-reader"

URL = "http://employmentsummary.abaquestionnaire.org/"

agent = Mechanize.new
# agent.pluggable_parser.pdf = Mechanize::Download # Mechanize::File # Mechanize::FileSaver Mechanize::Download
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

school_name = ["YALE UNIVERSITY", "CALIFORNIA-BERKELEY, UNIVERSITY OF"].sample
school_selector = page.form.field_with(:name => 'ddlUniversity')
school_option = school_selector.options.find{|option| option.text == school_name}
school_option.select

#
# SUBMIT FORM
#

form = page.forms.first
button = page.form.button_with(:value => "Generate Report")
response = agent.submit(form, button) #> Mechanize::File

#
# DOWNLOAD PDF FILE
#

local_file = File.join(File.expand_path("../../tmp", __FILE__), "my_report.pdf")

FileUtils.rm_rf(local_file)

response.save(local_file)

#
# PARSE PDF FILE
#

io = local_file

reader = PDF::Reader.new(io) #> PDF::Reader::MalformedPDFError: PDF does not contain EOF marker

binding.pry


#puts "READING PDF WITH #{reader.pages.count} PAGES"

#FileUtils.rm_rf(local_file)

# text = IO.read(remote_file, mode: 'rb') # > ArgumentError: string contains null byte
# File.open(local_file, 'wb'){|f| f << remote_file}

#remote_file.save_as(local_file)

#File.open(file_source, "wb") do |local_file|
#  open(url, "rb") do |remote_file|
#    local_file.write(remote_file.read)
#  end
#end # > ArgumentError: string contains null byte

#io = response.body
#reader = PDF::Reader.new(io)
#lines = reader.pages.first.text.split("\n")
#lines.select!{|line| line.size > 0 }
#lines.map!{|line| line.strip }
#raise LineCountError unless lines.count == 53
#return lines
