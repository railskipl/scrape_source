require_relative 'razr'

class Job
  include Razr
  attr_accessor :id, :location, :link, :title, :description, :company_id, :source, :type, :telecommute, :table

  def self.table
    @@table ||= "jobs"
  end
end