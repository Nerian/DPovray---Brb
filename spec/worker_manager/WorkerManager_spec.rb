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
    describe "#Split job in sub-jobs" do 
      it "Split 1 job, with 1 core" do
        number_of_cores = 1
        job1 = Job::Job.new("project:4", 0, 100)
        
        subjob1 = Job::Job.new("project:4", 0, 50)
        subjob2 = Job::Job.new("project:4", 50, 100)
        
        worker_manager = WorkerManager.new(number_of_cores)        
        worker_manager.addJob(job1)        
        worker_manager.split_job()
        worker_manager.subjobs.should have(2).Jobs                
        worker_manager.subjobs.include?(subjob1).should == true
        worker_manager.subjobs.include?(subjob2).should == true
      end
      
      it "Split 1 job, with 2 core" do
        number_of_cores = 2
        job1 = Job::Job.new("project:4", 0, 100)
        
        subjob1 = Job::Job.new("project:4", 0, 25)
        subjob2 = Job::Job.new("project:4", 25, 50 )
        subjob3 = Job::Job.new("project:4", 50, 75)
        subjob4 = Job::Job.new("project:4", 75, 100)
        
        worker_manager = WorkerManager.new(number_of_cores)        
        worker_manager.addJob(job1)        
        worker_manager.split_job()
        worker_manager.subjobs.should have(4).Jobs
        
        worker_manager.subjobs.include?(subjob1).should == true
        worker_manager.subjobs.include?(subjob2).should == true
        worker_manager.subjobs.include?(subjob3).should == true
        worker_manager.subjobs.include?(subjob4).should == true
        
      end
      
      it "Split 1 job, with 3 cores" do
        number_of_cores = 3
        job1 = Job::Job.new("project:4", 0, 100)
        
        subjob1 = Job::Job.new("project:4", 0, 16)
        subjob2 = Job::Job.new("project:4", 16, 32 )
        subjob3 = Job::Job.new("project:4", 32, 48)
        subjob4 = Job::Job.new("project:4", 48, 64)
        subjob5 = Job::Job.new("project:4", 64, 80)
        subjob6 = Job::Job.new("project:4", 80, 100)
        
        worker_manager = WorkerManager.new(number_of_cores)        
        worker_manager.addJob(job1)        
        worker_manager.split_job()
        worker_manager.subjobs.should have(6).Jobs
        
        worker_manager.subjobs.include?(subjob1).should == true
        worker_manager.subjobs.include?(subjob2).should == true
        worker_manager.subjobs.include?(subjob3).should == true
        worker_manager.subjobs.include?(subjob4).should == true
        worker_manager.subjobs.include?(subjob5).should == true
        worker_manager.subjobs.include?(subjob6).should == true        
      end
                                          
    end                                             
  end
end