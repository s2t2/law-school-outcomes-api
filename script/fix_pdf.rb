require "pry"
require "pdf-reader"

#BOF = "%PDF-1.3"
#EOF = "%%EOF"

local_file = File.join(File.expand_path("../../tmp", __FILE__), "good_report.pdf")

#File.open(local_file, "r") do |file|
#  file.each_line do |line|
#    puts line
#  end
#end

begin
  reader = PDF::Reader.new(local_file)
rescue PDF::Reader::MalformedPDFError #> PDF::Reader::MalformedPDFError: PDF does not contain EOF marker



binding.pry

  content = File.open(local_file, 'r') { |io| io.read }
  pdf_content = content.split("%%EOF").first




  string.gsub("\u0000", '')
  reader = PDF::Reader.new(pdf_content)





end

puts "SUCCESS"
