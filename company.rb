class Company
  attr_accessor :name, :link, :description, :id

  def jobs
    results = JobDatabase.new.find_jobs_by_company_id(self.id)
     jobs = results.map { |result| Job.new(result.first(9)) }
     return jobs
  end
end