=begin

#session = MySession.new
#session.select('YALE UNIVERSITY', from: 'ddlUniversity')
#session.click_button 'Generate Report'

#sleep 3

#session.open_page

# pdf_file = File.join(File.expand_path("../tmp/reports", __FILE__), "my_report.pdf")

# temp_pdf = Tempfile.new('pdf')
# temp_pdf << session.driver.response.body
# temp_pdf.close

# session.visit_page

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

pdf_file = File.join(File.expand_path("../tmp/reports", __FILE__), "my_report.pdf")

#
# Load PDF contents into tempfile
#

# temp_pdf = Tempfile.new('pdf')
# temp_pdf << session.driver.response.body
# temp_pdf.close

# reader = PDF::Reader.new(io)
# lines = reader.pages.first.text.split("\n")

=end
