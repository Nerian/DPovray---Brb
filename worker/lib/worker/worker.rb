module Worker
  
  class Project_Server         
    def find_pov_file(name)
      povray_scene_string = ''
      file = File.new("povray.pov","r")
      file.each_line do |line| 
        povray_scene_string +=line
      end
      file.close
      marshaled_povray_scene_file = Marshal.dump(povray_scene_string)
    end
  end
  
  class Worker
    @project_server
    @job    
    def initialize(output=STDOUT) 
      @output = output          
      @project_server = Project_Server.new
    end
        
    def add_job(serialized_job)      
      #puts "Received a new Job"                
      @output.puts 'Received a new Job'  
                                       
      @output.puts 'Unmarshaling the Object...'
      @job = Marshal.load(serialized_job)
      if @job.instance_of? Job::Job                  
        @output.puts 'Unmarshaling completed'
      else
        @output.puts 'Failed to Unmarshal de Job'
      end
    end
    
    def retrieve_pov_file_from_server()                         
      @output.puts 'Asking for .pov file'
      marshaled_povray_scene_file = @project_server.find_pov_file(@job.povray_scene_file_name)
      if(marshaled_povray_scene_file.nil?)
        @output.puts 'Failed to receive povray scene file'
      else
        @output.puts 'Received marshaled .Pov file'
        @output.puts 'Unmarshaling .pov file'
        povray_scene_file = Marshal.load(marshaled_povray_scene_file)
        if (povray_scene_file.nil?)
          @output.puts 'Failed to unmarshal marshaled povray scene file'
        else          
          @output.puts 'Pov file ready'
        end
      end
    end               
    
  end  
end