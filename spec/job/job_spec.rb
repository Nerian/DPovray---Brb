require 'spec_helper'

module Job
  describe "Job" do
    describe "#Initialize" do
      it "Initialise with correct arguments, string" do
        id = "project1:job10"
        starting_column = '0'
        ending_colum = '100'
        job = Job.new(id, starting_column, ending_colum)                                      
        job.starting_column.should == 0
        job.ending_column.should == 100         
      end
      
      it "Initialise with correct arguments, string with %" do
        id = "project1:job10"
        starting_column = '0%'
        ending_colum = '100%'
        job = Job.new(id, starting_column, ending_colum)                                      
        job.starting_column.should == 0
        job.ending_column.should == 100         
      end
      
      it "Initialise with correct arguments, integer" do 
        id = "project1:job10"
        starting_column = 0
        ending_colum = 100
        job = Job.new(id, starting_column, ending_colum)                                      
        job.starting_column.should == 0
        job.ending_column.should == 100        
      end                                       
      
      it "Should raise exception if starting column is not positive" do
        id = "project1:job10"
        starting_column = '-5'
        ending_colum = '5'
                
        lambda { job = Job.new(id, starting_column, ending_colum) }.should raise_error("starting column must be a positive number")
        
      end
      
      it "Should raise exception if ending column is not positive" do
        id = "project1:job10"
        starting_column = '5'
        ending_colum = '-5'
                
        lambda { job = Job.new(id, starting_column, ending_colum) }.should raise_error("ending column must be a positive number")        
      end              
    end
    
    describe "#Equality" do
      it "Should say two Jobs are the same if they have the same attributes" do
         job1 = Job.new("1",0, 100)
         job2 = Job.new("1",0, 100)
         job1.should == job2
         
      end
    end            
  end  
end