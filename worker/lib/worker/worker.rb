module Worker
  class Worker    
    def initialize(output)    
      @output = output  
    end
        
    def add_job(options, file_name)      
      #puts "Received a new Job"                
      @output.puts 'Received a new Job'
    end               
    
  end  
end