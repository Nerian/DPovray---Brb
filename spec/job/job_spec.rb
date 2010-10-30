require 'spec_helper'

module Job
  describe "Job" do
    describe "#Initialize" do
      it "Initialise with correct arguments, string" do
        id = "project1:job10"
        starting_column = '0'
        ending_colum = '100'
        job = Job.new(id, starting_column, ending_colum)                                      
        job.starting_column.should == starting_column
        job.ending_column.should == ending_colum         
      end
      
      it "Initialise with correct arguments, integer" do 
        id = "project1:job10"
        starting_column = 0
        ending_colum = 100
        job = Job.new(id, starting_column, ending_colum)                                      
        job.starting_column.should == starting_column
        job.ending_column.should == ending_colum        
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
    
    
    
  end
  
end