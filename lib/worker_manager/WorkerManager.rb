module WorkerManager
  class WorkerManager
    
    attr_accessor :cores, :job, :subjobs
    
    def initialize(number_of_cores)
      unless number_of_cores.to_i > 0  
        raise ArgumentError, 'Number of cores must be a positive number'
      end               
      @cores = number_of_cores.to_i
      @job = nil     
    end                       
    
    def addJob(job)           
      if @job.nil?
        @job = job      
      else
        raise ArgumentError, "Error: WorkerManager already got a Job assigned. It can only manage one at a time" 
      end
    end       
    
    def split_job()           
      @subjobs = divide2(@job)    
    end      
    
    def divide2(job)
      new_array_of_job = []
      
      number_of_jobs_that_we_want_to_create = @cores * 2   
         
      ec = job.ending_column.to_i / number_of_jobs_that_we_want_to_create
      sc = job.starting_column                                           
      
      number_of_jobs_that_we_want_to_create.times do |time|
        new_job = Job::Job.new(@job.id, ec*time, ec+(ec*time))
        new_array_of_job.push(new_job)
      end           
      
      new_array_of_job.last.ending_column = job.ending_column
             
      return new_array_of_job
                        
    end           
    
    def divide(array_of_job)      
      new_array_of_job = []
      
      array_of_job.map do |job| 
        
        #First slice              
        sc = job.starting_column
        ec = job.ending_column / 2                    
        new_job = Job::Job.new(job.id, sc, ec)
        new_array_of_job.push(new_job)        
        
        #Second Slice
        sc = job.ending_column / 2
        ec = job.ending_column       
        new_job = Job::Job.new(job.id, sc, ec)
        new_array_of_job.push(new_job)
        
      end
      return new_array_of_job           
    end                            
    
  end
end