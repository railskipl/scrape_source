class Scraper
  require 'nokogiri'
  require 'open-uri'
  require_relative 'job_database'
  
  attr_accessor :source, :index_url, :index_doc, :job_url_collection, :base_url_for_job, :title_selector, :company_selector,
                :location_selector, :type_selector, :job_database

  def initialize(source, index_url, base_url_for_job, job_database)
    @source           = source
    @index_url        = index_url
    @base_url_for_job = base_url_for_job
    @job_database     = job_database
    @index_doc        = Nokogiri::HTML(open(self.index_url))
  end

  def compile_job_url_collection(job_selector)
    self.job_url_collection = self.index_doc.css(job_selector).slice(0..10).map do |link| 
      "#{self.base_url_for_job}#{link['href']}"
    end
  end

  def scrape_away(args)
    threads = []
    self.job_url_collection.each do |job_url|
      threads << Thread.new do
        job_doc     = Nokogiri::HTML(open(job_url))
        title       = job_doc.css(args[:title_selector]).inner_text.strip
        company     = job_doc.css(args[:company_selector]).inner_text.strip
        source      = self.source
        job_url     = job_url.strip
        location    = job_doc.css(args[:location_selector]).inner_text.strip
        job_type    = job_doc.css(args[:job_selector]).inner_text.strip
        telecommute = "Empty for now"
        description = job_doc.css(args[:description_selector]).inner_text.strip

        self.job_database.insert_row([title, source, job_url, company, location, job_type, telecommute, description])
      end
    end
    threads.each(&:join)
  end
end
