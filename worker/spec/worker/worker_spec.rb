require 'spec_helper'

module Worker
  describe Worker do 
    let(:output) {double('output').as_null_object}
    let(:job) {Job::Job.new('project_name', '-w320 -h120', 'povray.pov', 'partial_image_file_name')}  
    let(:worker) {Worker.new(output)}
        
    describe "#add_job" do          
      it "sends a received message" do              
        output.should_receive(:puts).with('Received a new Job')
        worker.add_job(job.serialize())        
      end                                                      
      
      it "sends a unmarshaling the Job message" do 
        output.should_receive(:puts).with('Unmarshaling the Object...')
        worker.add_job(job.serialize())
      end 
      
      it "sends a unmarshaling completion message" do
        output.should_receive(:puts).with('Unmarshaling completed')
        worker.add_job(job.serialize())
      end
    end  
    
    describe "#retrieve_pov_file_from_server" do
      it "Ask for the .pov file" do
        output.should_receive(:puts).with('Asking for .pov file') 
        worker.add_job(job.serialize())
        worker.retrieve_pov_file_from_server()       
      end
      
      it "receive marshaled scene file" do
        output.should_receive(:puts).with("Received marshaled .Pov file")
        worker.add_job(job.serialize())
        worker.retrieve_pov_file_from_server()
        
      end
      
      it "send message 'Unmarshaling .pov file'" do 
        output.should_receive(:puts).with("Unmarshaling .pov file")
        worker.add_job(job.serialize())
        worker.retrieve_pov_file_from_server()
      end      
      
      it "send message that the file is ready" do
        output.should_receive(:puts).with("Pov file ready")
        worker.add_job(job.serialize())
        worker.retrieve_pov_file_from_server()        
      end           
    end    
  end
end