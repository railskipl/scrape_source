module Flatiron
  module ClassMethods
    def all
      results = Database.new.all_rows(self.table)
      results.map { |result| self.new(result.first(result.size/2)) }
    end
  end
  
  module InstanceMethods
    
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end