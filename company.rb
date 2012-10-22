class Company
  attr_accessor :name, :link, :description, :id

  

  def jobs
    JobDatabase.new.find_jobs_by_company_id(self.id)

  end


end