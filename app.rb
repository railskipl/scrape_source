require_relative 'scraper'
require_relative 'job_database'
require 'benchmark'

JobDatabase.drop_database
job_database = JobDatabase.new

time = Benchmark.measure do
  
  ruby_inside = Scraper.new('Ruby Inside', 'http://ruby.jobamatic.com/a/jbb/find-jobs/', 
                            'http://ruby.jobamatic.com', job_database)
  ruby_inside.compile_job_url_collection('tr.listing td.title a')
  ruby_inside.scrape_away({
    :title_selector => 'h2.jam_headline',
    :company_selector => 'h3 a.jam_link',
    :location_selector => 'div#c_address',
    :job_selector => 'div#c_jobtype',
    :description_selector => 'div#c_job_description'
  })

  ruby_now = Scraper.new('Ruby Now', 'http://jobs.rubynow.com/', 
                         'http://jobs.rubynow.com', job_database)
  ruby_now.compile_job_url_collection('ul.jobs li h2 a:first')
  ruby_now.scrape_away({
    :title_selector => 'h2#headline',
    :company_selector => 'h2#headline a',
    :location_selector => 'h3#location',
    :job_selector => 'strong:last',
    :description_selector => 'div#info'
  })

end

puts time
