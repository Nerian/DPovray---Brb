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
      
      number_of_real_process = @cores * 2
      number_of_columns_to_render = @job.ending_column - @job.starting_column
                                                        
      number_of_jobs_that_we_want_to_create = number_of_real_process
      if((number_of_columns_to_render/number_of_real_process) < 1) 
        number_of_jobs_that_we_want_to_create = number_of_columns_to_render
      end
              
      @subjobs = generate_subjobs(number_of_jobs_that_we_want_to_create)      
      
    end
    
     def generate_subjobs(number_of_jobs_that_we_want_to_create)
       new_array_of_job = []
       
       render_unit = (job.ending_column - job.starting_column)  / number_of_jobs_that_we_want_to_create
       sc = job.starting_column                                           

       number_of_jobs_that_we_want_to_create.times do |time|
         new_job = Job::Job.new(@job.id, sc+render_unit*time, sc+render_unit+(render_unit*time))
         new_array_of_job.push(new_job)
       end        
       
       new_array_of_job.last.ending_column = job.ending_column            
       return new_array_of_job
     end                                                        
  end
end