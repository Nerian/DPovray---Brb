module Worker
  class Worker
    @job    
    def initialize(output=STDOUT) 
      @output = output      
    end
        
    def add_job(serialized_job)      
      #puts "Received a new Job"                
      @output.puts 'Received a new Job'  
                                       
      @output.puts 'Unmashaling the Object...'
      @job = Marshal.load(serialized_job)
      if @job.instance_of? Job::Job                  
        @output.puts 'Unmashaling completed'
      end
    end               
    
  end  
end