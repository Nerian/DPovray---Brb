# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc

require 'spec_helper'
            
module Worker
  describe Worker do 
    let(:output) {double('output').as_null_object}
    let(:job) {Job::Job.new('cucu:1', 0,100)}
    let(:marshaled_job) {Marshal.dump(job)}
    let(:project_server) {double('project_server').as_null_object}  
    let(:worker) {Worker.new(output, 1)}
    let(:marshaled_povray_scene_file){   
      povray_scene_string = ''
      file = File.new("povray.pov","r")
      file.each_line do |line| 
        povray_scene_string +=line
      end
      file.close                                                             
      marshaled_povray_scene_file = Marshal.dump(povray_scene_string)        
    }
    let(:tmp_folder_path){"/tmp/#{worker.id}"}                          
         
    
    describe "#Initialize" do
      it "Should initialize with correct arguments" do
        worker = Worker.new('worker:1')
      end
    end
    
    describe "#Create_folder_structure" do
      
      it "Generate folder structure when there was nothing there before" do
        FileUtils.rm_rf(tmp_folder_path)
        Dir.exist?(tmp_folder_path).should == false
        worker.create_folder_structure()
        Dir.exist?(tmp_folder_path).should == true
        Dir.entries(tmp_folder_path).count.should == 2  #  '.' and '..'         
        worker.tmp_folder.should_not be(nil)                        
      end
      
      it "Generate folder structure when there was something there before" do
        FileUtils.rm_rf(tmp_folder_path)
        FileUtils.mkdir(tmp_folder_path)
        worker.create_folder_structure()
        Dir.exist?(tmp_folder_path).should == true
        Dir.entries(tmp_folder_path).count.should == 2  #  '.' and '..'        
      end
            
    end
            
    describe "#add_job(job)" do      
                      
      it "Worker received a new Job" do
        job = Job::Job.new('job:1', 0, 100)              
        worker.add_job(job)
        worker.job.should_not be(nil)                
      end                                                      
      
      it "Worker try to unmarshal the received Job" do 
        job = Job::Job.new('job:1', 0, 100)
        worker.add_job(job)            
        worker.job.should_not be(nil)
      end 
      
      it "Worker succefully unmarshaled the job" do
        job = Job::Job.new('job:1', 0, 100)
        worker.add_job(job)
        worker.job.should_not be(nil)
      end
    end  
    
    describe "#retrieve_pov_file_from_server()" do                
      
      
    end                          
    
    describe "#povray_start_render()" do
      
      before(:each) do
        worker.add_job(job)        
        worker.retrieve_pov_file_from_server()
        File.exist?("#{tmp_folder_path}/povray.pov").should == true         
      end
      
      it "Worker start a Povray process" do
        worker.povray_start_render()
      end                          
      
      it "Povray command was ran" do          
        worker.povray_start_render()
      end
      
      it "Image was rendered succefully" do         
        worker.povray_start_render()                                                
        File.exist?("#{tmp_folder_path}/partial_image.tga").should == true
      end
    end
    describe "#send_rendered_image_to_job_requester()" do                                                           
      
      before(:each) do
        worker.add_job(job)        
        worker.retrieve_pov_file_from_server()
        worker.povray_start_render()
      end
      
      it "Worker contact project server" do
        worker.send_rendered_image_to_job_requester()        
      end
      
      it "Worker send partial image to project server" do
        worker.send_rendered_image_to_job_requester()        
      end
    end
    
    describe "#Clean up tmp directory" do
      it "Worker remove its tmp directory" do
        worker.cleanup()        
        Dir.exist?("#{tmp_folder_path}").should == false
      end
    end
                                                     
  end
end