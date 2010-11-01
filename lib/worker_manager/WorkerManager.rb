module WorkerManager

  # The WorkerManager is a controller kind of component. The WorkerManager duty is to use the processing power
  # of a single machine at its fullest. In order to do this every time the WorkerManager receives a Job it will
  # divide it in many subjobs. For every subjob it will create a Worker, which will be a separate process.
  # The number of workers depends on the number of cpu of the machine.
  #
  # By using this process we ensure that all cpu cores are used in parallel.
  class WorkerManager

    # @return [Integer] The max number of cores that can be used.
    attr_reader :cores  

    # @return [Job] The current job. 
    attr_reader :job

    # @return [Array<Job>] The current list of subjobs.
    attr_reader :subjobs 

    # @return [Array<Worker>] The list of workers that the Worker_Manager is using to render a scene.
    attr_reader :workers


    # Instantiates a WorkerManager object.
    #
    # @param [Number] number_of_cores number of cpu cores that the machine on 
    # which WorkerManager is executed. The bigger, the more povray process there will be created.
    # @return [WorkerManager] 
    def initialize(number_of_cores)
      unless number_of_cores.to_i > 0  
        raise ArgumentError, 'Number of cores must be a positive number'
      end               
      @cores = number_of_cores.to_i
      @job = nil
      @subjobs = []  
      @work_counter = 0
      @number_of_completions = 0
    end                       

    # Set the WorkerManager current Job. 
    #
    # @param [Job] job The job object that you want to set as the WorkerManager's active job 
    # @raise [ArgumentError] Raises ArgumentError if the WorkerManager already has a job assigned
    # @return [Job] The job that was assigned.
    def addJob(job)           
      if @job.nil?
        @job = job      
      else
        raise ArgumentError, "Error: WorkerManager already got a Job assigned. It can only manage one at a time" 
      end
    end       

    # It uses the current job as set in self.job to generate self.subjobs. 
    # Each job inside subjobs is defined to render just a portion of the parent job (self.job). 
    # The render of the subjobs list gives the same result that rendering self.job. 
    # The intended usage of that list is for distribution of tasks between severals workers.
    # That list could be accessed as self.subjobs. The number of subjobs created depends on the 
    # number of cores, as set in self.cores
    #
    # @param None
    # @return [Array<Job>] The list of subjobs. It is the same as self.subjobs
    def split_job()           

      number_of_real_process = @cores * 2
      number_of_columns_to_render = @job.ending_column - @job.starting_column

      number_of_jobs_that_we_want_to_create = number_of_real_process
      if((number_of_columns_to_render/number_of_real_process) < 1) 
        number_of_jobs_that_we_want_to_create = number_of_columns_to_render
      end

      @subjobs = generate_subjobs(number_of_jobs_that_we_want_to_create)      

    end

    def report(message)
      @number_of_completions += 1
      if @number_of_completions == @subjobs.count        
        BrB::Service.stop_service()
        EM.stop
      end
    end       

    # It instantiate many workers 
    def render_scene()  
      @workers = []                         
      @worker_pid = []
                     
      counter = 1
      @subjobs.each do |subjob|                                        
        fork {                                 
          worker = Worker::Worker.new("worker:#{counter}")
          worker.start_your_work(subjob.serialize)
        }                                       
        counter +=1
      end
 
      EM::run do # Start event machine
        # Start BrB Service, expose an instance of core object to the outside world
        BrB::Service.start_service(:object => self,:verbose => true, :host => 'localhost', :port => 5555)
      end        
            
    end

    private 
    # It generates a subjob list. It will use self.job to generate a list of jobs whose render 
    # will equal to the render of self.job. The subjob list it meant to be used by child Workers.  
    #
    # @param [Number] number_of_jobs_that_we_want_to_create It's the number of scene divisions 
    #   that self.job is going to suffer. 
    # @return [Array<Job>] It is the resulting subjob list.    
    def generate_subjobs(number_of_jobs_that_we_want_to_create)
      subjob_list = []

      render_unit = (job.ending_column - job.starting_column)  / number_of_jobs_that_we_want_to_create
      sc = job.starting_column                                           

      number_of_jobs_that_we_want_to_create.times do |time|
        new_job = Job::Job.new(@job.id, sc+render_unit*time, sc+render_unit+(render_unit*time))
        subjob_list.push(new_job)
      end        

      subjob_list.last.ending_column = job.ending_column            
      return subjob_list
    end                                                        
  end
end