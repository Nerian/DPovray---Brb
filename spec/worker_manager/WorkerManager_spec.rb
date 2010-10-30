require 'spec_helper'

module WorkerManager
  describe WorkerManager do
    describe "#Initialize a worker manager" do      
      it "initialize with even number of cores" do         
        number_of_cores = 1
        worker_manager = WorkerManager.new(number_of_cores)        
        worker_manager.cores.should == 1
      end                                                 
      
      it "should raise exception if initialised with a negative number of cores" do
        number_of_cores = -2                
        lambda { WorkerManager.new(number_of_cores) }.should raise_error('Number of cores must be a positive number')                                        
      end                                                                                                            
      
      it "should raise exception if initialised with 0 cores" do
        number_of_cores = 0
        lambda { WorkerManager.new(number_of_cores) }.should raise_error('Number of cores must be a positive number')                
      end                  
    end
    
    describe "#Receive a Job" do      
      it "Receive a job and @job was nil" do                               
        number_of_cores = 1              
        job = Job::Job.new("project:4", 0, 100)
        
        worker_manager = WorkerManager.new(number_of_cores)        
        worker_manager.addJob(job)
        worker_manager.job.should be(job)
      end   
      
      it "Receive a job when already had one" do
        number_of_cores = 1
        job1 = Job::Job.new("project:4", 0, 100)
        job2 = Job::Job.new("project:5", 0, 100) 
        
        worker_manager = WorkerManager.new(number_of_cores)        
        worker_manager.addJob(job1)
        worker_manager.job.should be(job1)
        
        lambda {worker_manager.addJob(job2)}.should raise_error("Error: WorkerManager already got a Job assigned. It can only manage one at a time")          
        
        worker_manager.job.should be(job1)    
        
      end      
    end                                         
  end
end