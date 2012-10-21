class Scraper
  require 'nokogiri'
  require 'open-uri'
  
  attr_accessor :source, :index_url, :index_doc, :job_url_collection, :base_url_for_job, :job_database

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
    self.job_url_collection.each do |job_url|
      values, columns, markers = [], [], []
      job_doc  = Nokogiri::HTML(open(job_url))
    
      args.each do |key, selector|
        column_name, option = key.to_s.split("_")
        columns << column_name
        values << job_doc.css(selector).send(option.to_sym).strip
        markers = Array.new(columns.size, "?").join(",")
      end      

      self.job_database.insert_record(columns, markers, values)
    end
  end
end
