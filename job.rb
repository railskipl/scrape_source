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
end