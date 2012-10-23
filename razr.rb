module Razr
  module ClassMethods

    def all
      results = Database.new.all_rows(self.table)
      results.map { |result| self.new(result.first(result.size/2)) }
    end

    def find(id)
      result = Database.new.find_obj_by_id(id, self.table)
      Job.new(result.first(result.size/2))
    end

  end
  
  module InstanceMethods

    def initialize(args={})
      args.each do |key, value|
        self.send("#{key.to_sym}=", value)
      end
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
      Database.new.insert_record(columns, args, self.class.table)
    end    
  
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end