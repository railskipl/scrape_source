require 'nokogiri'
require 'open-uri'
require_relative 'job_database'

JobDatabase.drop_database
job_database = JobDatabase.new

index_url = 'http://jobs.rubynow.com/'
job_index_doc = Nokogiri::HTML(open(index_url))

job_urls = job_index_doc.css('ul.jobs li h2 a:first').map do |link| 
  "http://jobs.rubynow.com#{link['href']}"
end

job_urls.each do | job_url|    
  job_listing_doc = Nokogiri::HTML(open(job_url))
  title, company = job_listing_doc.css('h2#headline').inner_text.chomp.split(" at ")
  source = "Ruby Now"
  job_url = job_url.chomp
  location = job_listing_doc.css('h3#location').inner_text.chomp
  job_type = job_listing_doc.css('strong:last').inner_text.chomp
  telecommute = "Empty fornow"
  description = job_listing_doc.css('div#info').inner_text.chomp

  job_database.insert_row([title, source, job_url, company, location, job_type, telecommute, description])
end
