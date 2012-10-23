require_relative 'flatiron'

class Company
  include Flatiron

  attr_accessor :name, :link, :description, :id, :table

  def initialize(args={})
    args.each do |key, value|
      self.send("#{key.to_sym}=", value)
    end
  end

  def self.table
    @@table ||= "companies"
  end

  def ==(other_instance)
    self.id == other_instance.id
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

  def jobs
    results = Database.new.find_jobs_by_company_id(self.id)
     jobs = results.map { |result| Job.new(result.first(9)) }
     return jobs
  end


  def self.find(id)
    result = Database.new.find_obj_by_id(id, "jobs")
    Company.new(result.first(4))
  end
end
