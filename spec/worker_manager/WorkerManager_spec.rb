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
      
      it "Receive a job" do                               
        number_of_cores = 1
        worker_manager = WorkerManager.new(number_of_cores)        
        worker_manager.addJob(Job::Job.new("project:4", 0, 100))
      end
      
    end
                             
  end
end