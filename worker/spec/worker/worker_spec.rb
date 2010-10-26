# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc

require 'spec_helper'
require 'BrB'
            
module Worker
  describe Worker do 
    let(:output) {double('output').as_null_object}
    let(:job) {Job::Job.new('project_name', '-w50 -h50', 'povray.pov')}
    let(:marshaled_job) {Marshal.dump(job)}
    let(:project_server) {double('project_server').as_null_object}  
    let(:worker) {Worker.new(output)}
    let(:marshaled_povray_scene_file){   
      povray_scene_string = ''
      file = File.new("povray.pov","r")
      file.each_line do |line| 
        povray_scene_string +=line
      end
      file.close                                                             
      marshaled_povray_scene_file = Marshal.dump(povray_scene_string)        
    }            
        
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
      
      before(:each) do
        worker.add_job(marshaled_job, project_server)
        project_server.stub(:find_pov_file).and_return(marshaled_povray_scene_file)         
      end     
      
      it "Worker ask for the .pov file" do
        output.should_receive(:puts).with('Asking for .pov file')
        worker.retrieve_pov_file_from_server()       
      end
      
      it "Worker received marshaled scene file" do
        output.should_receive(:puts).with("Received marshaled .Pov file")
        project_server.should_receive(:find_pov_file).with(job.povray_scene_file_name).and_return(marshaled_povray_scene_file)
        worker.retrieve_pov_file_from_server()        
      end
      
      it "Worker is trying to unmarshal pov file" do 
        output.should_receive(:puts).with("Unmarshaling .pov file")
        worker.retrieve_pov_file_from_server()
      end      
      
      it "Worker succefully unmarshaled the pov file" do
        output.should_receive(:puts).with("Pov file succefully unmarshaled")
        worker.retrieve_pov_file_from_server()        
      end                    
      
      it "Worker saved scene to temp file" do
        output.should_receive(:puts).with("Pov file saved to temporal file")                
        worker.retrieve_pov_file_from_server()        
      end
    end                          
    
    describe "#povray_start_render()" do
      after(:each) do
        File.delete("/tmp/povray.pov")
      end     
      
      before(:each) do
        worker.add_job(job.serialize(), project_server)        
        project_server.stub(:find_pov_file).and_return(marshaled_povray_scene_file)
        worker.retrieve_pov_file_from_server()         
      end
      
      it "Worker start a Povray process" do
        output.should_receive(:puts).with("Povray render process started")
        worker.povray_start_render()
      end                          
      
      it "Povray command was ran" do          
        output.should_receive(:puts).with("Povray command was run")
        worker.povray_start_render()
      end
      
      it "Image was rendered succefully" do         
        output.should_receive(:puts).with("Partial image was rendered successfully")
        worker.povray_start_render()
      end
    end
    describe "#send_rendered_image_to_job_requester()" do      
      after(:each) do
        File.delete("/tmp/povray.pov")                        
      end                                                                 
      
      before(:each) do
        worker.add_job(job.serialize(), project_server)        
        project_server.stub(:find_pov_file).and_return(marshaled_povray_scene_file)       
        worker.retrieve_pov_file_from_server()
        worker.povray_start_render()
      end
      
      it "Worker contact project server" do
        output.should_receive(:puts).with("Connection with server stablished")           
        worker.send_rendered_image_to_job_requester()        
      end
      
      it "Worker send partial image to project server" do
        output.should_receive(:puts).with("Image successfully sent")
        project_server.should_receive(:put).with(marshaled_job,/\w/).and_return(true)      
        worker.send_rendered_image_to_job_requester()        
      end
    end                                                 
  end
end