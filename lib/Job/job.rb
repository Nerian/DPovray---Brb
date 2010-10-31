# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc

module Job
  class Job     
    
    attr_accessor :id, :starting_column, :ending_column 
    
    def initialize(id, starting_column, ending_column)
      @id = id                      
      
      unless starting_column.to_i >= 0       
        raise ArgumentError, "starting column must be a positive number"
      end
      
      unless ending_column.to_i >= 0
        raise ArgumentError, "ending column must be a positive number"        
      end
      @starting_column = starting_column
      @ending_column = ending_column      
    end  
    
    def serialize
      Marshal.dump(self)
    end
    
    def self.deserialize(serialized_job)
      Marshal.load(serialized_job)
    end             
    
    def ==(some_other_job)
      if self.id == some_other_job.id and self.starting_column == some_other_job.starting_column and self.ending_column == some_other_job.ending_column
        return true
      else
        return false
      end
    end
    
    def to_s
      return "id:#{self.id} starting_column:#{self.starting_column} ending_column:#{self.ending_column}" 
    end
                                                              
  end
end