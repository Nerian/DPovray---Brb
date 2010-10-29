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
      @starting_column = starting_column
      @ending_column = ending_column      
    end  
    
    def serialize
      Marshal.dump(self)
    end
    
    def self.deserialize(serialized_job)
      Marshal.load(serialized_job)
    end
                                                              
  end
end