require_relative 'flatiron'

class Job
  include Flatiron
  attr_accessor :id, :location, :link, :title, :description, :company_id, :source, :type, :telecommute, :table

  def initialize(args={})
    args.each do |key, value|
      self.send("#{key.to_sym}=", value)
    end
  end

  def self.table
    @@table ||= "jobs"
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
    Database.new.insert_record(columns, args, "jobs")
  end

  def self.find(id)
    result = Database.new.find_obj_by_id(id, "jobs")
    Job.new(result.first(9))
  end
end