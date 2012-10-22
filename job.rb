class Job
  attr_accessor :id, :location, :link, :title, :description, :company_id, :source, :type, :telecommute

  def initialize(args={})
    args.each do |key, value|
      self.send("#{key.to_sym}=", value)
    end
  end

  def self.all
    results = JobDatabase.new.all_rows('jobs')
    results.map { |result| Job.new(result.first(9)) }
  end


  def save
    db = JobDatabase.new
    columns = self.instance_variables.map do |var|
      var.to_s.sub("@", "")
    end
    markers = Array.new(columns.size, "?").join(",")
    args = columns.map do |col|
      self.send(col.to_sym)
    end
    db.insert_record(columns, markers, args)
  end


end