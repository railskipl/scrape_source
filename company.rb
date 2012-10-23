require_relative 'razr'

class Company
  include Razr
  attr_accessor :name, :link, :description, :id, :table

  def self.table
    @@table ||= "companies"
  end

  def jobs
    results = Database.new.find_jobs_by_company_id(self.id)
     jobs = results.map { |result| Job.new(result.first(9)) }
     return jobs
  end
end
