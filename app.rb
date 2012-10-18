require_relative 'scraper'
require_relative 'job_database'

JobDatabase.drop_database
job_database = JobDatabase.new

ruby_inside_scrape = Scraper.new("Ruby Now", "http://jobs.rubynow.com/", job_database)
ruby_inside_scrape.compile_job_urls('ul.jobs li h2 a:first')
ruby_inside_scrape.scrape_away({
  :title_selector => 'h2#headline',
  :company_selector => 'h2#headline',
  :location_selector => 'h3#location',
  :job_selector => 'strong:last',
  :description_selector => 'div#info'
})

# ruby_inside_scrape = Scraper.new("Ruby Inside", 'http://ruby.jobamatic.com/a/jbb/find-jobs/', job_database)
# ruby_inside_scrape.compile_job_urls('tr.listing td.title a')
# ruby_inside_scrape.scrape_away({
#   :title_selector => 'h2.jam_headline',
#   :company_selector => 'h3 a.jam_link',
#   :location_selector => 'div#c_address',
#   :job_selector => 'div#c_jobtype',
#   :description_selector => 'div#c_job_description'
# })
