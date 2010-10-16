require 'spec_helper'

module Worker
  describe Worker do
    describe "#add_job" do   
      let(:output) {double('output').as_null_object}
      let(:job) {Job::Job.new('project_name', '-w320 -h120', 'povray.pov', 'partial_image_file_name')}  
      let(:worker) {Worker.new(output)} 
      
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
  end
end