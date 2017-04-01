require "pry"
require "json"
require "mechanize"
require "pdf-reader"

URL = "http://employmentsummary.abaquestionnaire.org/"
year = 2015
school_name = "YALE UNIVERSITY"
local_file = File.join(File.expand_path("../../tmp/reports", __FILE__), "my_report.pdf")

agent = Mechanize.new
agent.pluggable_parser.pdf = Mechanize::File # Mechanize::FileSaver Mechanize::Download
page = agent.get(URL)

year_selector = page.form.field_with(:name => 'ddlYear')
year_option = year_selector.options.find{|option| option.text == year.to_s}
year_option.select

school_selector = page.form.field_with(:name => 'ddlUniversity')
school_option = school_selector.options.find{|option| option.text == school_name}
school_option.select

form = page.forms.first
button = page.form.button_with(:value => "Generate Report")
response = agent.submit(form, button)

binding.pry


response.save_as(local_file)

#io = response.body_io
#reader = PDF::Reader.new(io) #> PDF::Reader::MalformedPDFError: PDF does not contain EOF marker






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
