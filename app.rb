require_relative 'scraper'
require_relative 'job_database'
require 'benchmark'

JobDatabase.drop_database
JobDatabase.create_database
job_database = JobDatabase.new

time = Benchmark.measure do
  
  ruby_inside = Scraper.new('Ruby Inside', 'http://ruby.jobamatic.com/a/jbb/find-jobs/', 
                            'http://ruby.jobamatic.com', job_database)
  ruby_inside.compile_job_url_collection('tr.listing td.title a')
  ruby_inside.scrape_away({
    title_text:       'h2.jam_headline',
    company_text:     'h3 a.jam_link',
    location_text:    'div#c_address',
    type_text:         'div#c_jobtype',
    description_text: 'div#c_job_description'
  })

  ruby_now = Scraper.new('Ruby Now', 'http://jobs.rubynow.com/', 
                         'http://jobs.rubynow.com', job_database)
  ruby_now.compile_job_url_collection('ul.jobs li h2 a:first')
  ruby_now.scrape_away({
    :title_text => 'h2#headline',
    :company_text => 'h2#headline a',
    :location_text => 'h3#location',
    :type_text => 'strong:last',
    :description_text => 'div#info'
  })

end

puts time
