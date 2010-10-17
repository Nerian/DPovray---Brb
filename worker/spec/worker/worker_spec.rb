# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc

require 'spec_helper'
require 'BrB'
            
module Worker
  describe Worker do 
    let(:output) {double('output').as_null_object}
    let(:job) {Job::Job.new('project_name', '-w50 -h50', 'povray.pov', 'partial_image_file_name')}
    let(:project_server) {double('project_server').as_null_object}  
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
      after(:each) do
        File.delete("/tmp/povray.pov")
      end
      
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
      
      it "Worker is trying to unmarshal pov file" do 
        output.should_receive(:puts).with("Unmarshaling .pov file")
        worker.add_job(job.serialize())
        worker.retrieve_pov_file_from_server()
      end      
      
      it "Worker succefully unmarshaled the pov file" do
        output.should_receive(:puts).with("Pov file succefully unmarshaled")
        worker.add_job(job.serialize())
        worker.retrieve_pov_file_from_server()        
      end                    
      
      it "Worker saved scene to temp file" do
        output.should_receive(:puts).with("Pov file saved to temporal file")                
        worker.add_job(job.serialize())
        worker.retrieve_pov_file_from_server()        
      end
    end
    describe "#povray_start_render()" do
      after(:each) do
        File.delete("/tmp/povray.pov", "/tmp/partial_image_file_name.png")
      end
      
      it "Worker start a Povray process" do
        output.should_receive(:puts).with("Povray render proccess started")
        
        worker.add_job(job.serialize())        
        worker.retrieve_pov_file_from_server()
        worker.povray_start_render()
      end                          
      
      it "Povray command was ran" do          
        output.should_receive(:puts).with("Povray command was run")
        
        worker.add_job(job.serialize())            
        worker.retrieve_pov_file_from_server()
        worker.povray_start_render()
      end
      
      it "Image was rendered succefully" do         
        output.should_receive(:puts).with("Partial image was rendered succefully")
        
        worker.add_job(job.serialize())               
        worker.retrieve_pov_file_from_server()
        worker.povray_start_render()
      end
    end
    describe "#send_rendered_image_to_job_requester()" do      
      after(:each) do
        File.delete("/tmp/povray.pov", "/tmp/partial_image_file_name.png")                
      end
      
      it "Worker contact project server" do
        output.should_receive(:puts).with("Connection with server stablished")   
        worker.add_job(job.serialize())        
        worker.retrieve_pov_file_from_server()
        worker.povray_start_render()
        worker.send_rendered_image_to_job_requester()        
      end
      
      it "Worker send partial image to project server" do
        output.should_receive(:puts).with("Image successfully sent")      
        worker.add_job(job.serialize())        
        worker.retrieve_pov_file_from_server()
        worker.povray_start_render()
        worker.send_rendered_image_to_job_requester()        
      end
    end                                                 
  end
end