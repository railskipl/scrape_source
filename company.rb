class Company
  attr_accessor :name, :link, :description, :id

  def initialize(args={})
    args.each do |key, value|
      self.send("#{key.to_sym}=", value)
    end
  end

  def jobs
    results = Database.new.find_jobs_by_company_id(self.id)
     jobs = results.map { |result| Job.new(result.first(9)) }
     return jobs
  end

  def save
    columns = self.instance_variables.map do |var|
      var.to_s.sub("@", "")
    end
    args = columns.map do |col|
      self.send(col.to_sym)
    end
    Database.new.insert_record(columns, args, "companies")
  end
end