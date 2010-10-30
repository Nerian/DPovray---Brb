module WorkerManager
  class WorkerManager
    
    attr_accessor :cores
    
    def initialize(number_of_cores)
      unless number_of_cores.to_i > 0  
        raise ArgumentError, 'Number of cores must be a positive number'
      end               
      @cores = number_of_cores     
    end                       
    
    
        
  end

end