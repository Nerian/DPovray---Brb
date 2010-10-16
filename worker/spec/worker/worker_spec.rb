require 'spec_helper'

module Worker
  describe Worker do 
    let(:output) {double('output').as_null_object}
    let(:job) {Job::Job.new('project_name', '-w320 -h120', 'povray.pov', 'partial_image_file_name')}  
    let(:worker) {Worker.new(output)}
        
    describe "#add_job(job)" do          
      it "Worker received a new Job" do              
        output.should_receive(:puts).with('Received a new Job')
        worker.add_job(job.serialize())        
      end                                                      
      
      it "Worker try to unmarshal the received Job" do 
        output.should_receive(:puts).with('Unmarshaling the Object...')
        worker.add_job(job.serialize())
      end 
      
      it "Worker succefully unmarshaled the job" do
        output.should_receive(:puts).with('Unmarshaling completed')
        worker.add_job(job.serialize())
      end
    end  
    
    describe "#retrieve_pov_file_from_server()" do
      it "Worker ask for the .pov file" do
        output.should_receive(:puts).with('Asking for .pov file') 
        worker.add_job(job.serialize())
        worker.retrieve_pov_file_from_server()       
      end
      
      it "Worker received marshaled scene file" do
        output.should_receive(:puts).with("Received marshaled .Pov file")
        worker.add_job(job.serialize())
        worker.retrieve_pov_file_from_server()
        
      end
      
      it "Worker is triying to unmarshal pov file" do 
        output.should_receive(:puts).with("Unmarshaling .pov file")
        worker.add_job(job.serialize())
        worker.retrieve_pov_file_from_server()
      end      
      
      it "Worker succefully unmarshaled the pov file" do
        output.should_receive(:puts).with("Pov file ready")
        worker.add_job(job.serialize())
        worker.retrieve_pov_file_from_server()        
      end           
    end    
  end
end