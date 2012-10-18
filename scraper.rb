class Scraper
  require 'nokogiri'
  require 'open-uri'
  require_relative 'job_database'
  
  attr_accessor :source, :index_url, :index_doc, :job_urls, :title_selector, :company_selector,
                :location_selector, :type_selector, :job_database

  def initialize(source, index_url, job_database)
    @source       = source
    @index_url    = index_url
    @job_database = job_database
    @index_doc    = Nokogiri::HTML(open(self.index_url))
  end

  def compile_job_urls(job_selector)
    self.job_urls = self.index_doc.css(job_selector).map do |link| 
      "#{self.index_url}#{link['href']}"
    end
    self.job_urls.pop(90) if self.source == "Ruby Inside"
  end

  def scrape_away(args)
    self.job_urls.each do |job_url|
      job_doc = Nokogiri::HTML(open(job_url))
      if self.source == "Ruby Now"
        title, company = job_doc.css(args[:title_selector]).inner_text.strip.split(" at ")
      else
        title = job_doc.css(args[:title_selector]).inner_text.strip
        company = job_doc.css(args[:company_selector]).inner_text.strip
      end
      source = self.source
      job_url = job_url.strip
      location = job_doc.css(args[:location_selector]).inner_text.strip
      job_type = job_doc.css(args[:job_selector]).inner_text.strip
      telecommute = "Empty for now"
      description = job_doc.css(args[:description_selector]).inner_text.strip

      self.job_database.insert_row([title, source, job_url, company, location, job_type, telecommute, description])
    end
  end
end
