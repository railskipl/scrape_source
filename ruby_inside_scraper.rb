require 'nokogiri'
require 'open-uri'
require_relative 'job_database'

JobDatabase.drop_database
job_database = JobDatabase.new

index_url = 'http://ruby.jobamatic.com/a/jbb/find-jobs'
job_index_doc = Nokogiri::HTML(open(index_url))

job_urls = job_index_doc.css('tr.listing td.title a').map do |link| 
  "http://ruby.jobamatic.com#{link['href']}"
end
#ew hack
job_urls.pop(90)

job_urls.each do | job_url|    
  job_listing_doc = Nokogiri::HTML(open(job_url))
  title = job_listing_doc.css('h2.jam_headline').inner_text.strip
  source = "Ruby Inside"
  job_url = job_url.strip
  company = job_listing_doc.css('h3 a.jam_link').inner_text.strip
  location = job_listing_doc.css('div#c_address').inner_text.strip
  job_type = job_listing_doc.css('div#c_jobtype').inner_text.strip
  telecommute = "Empty fornow"
  description = job_listing_doc.css('div#c_job_description').inner_text.strip

  job_database.insert_row([title, source, job_url, company, location, job_type, telecommute, description])
end
