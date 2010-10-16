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
          @output.puts 'Pov file succefully unmarshaled'
          file = File.open("/tmp/povray.pov","w") do |f|
            f.puts povray_scene_file                                  
          end            
          @output.puts "Pov file saved to temporal file"
        end
      end
    end            
    def povray_start_render()
      @output.puts 'Povray render started'
      if system("povray "+@job.povray_arguments+" -GAfile povray_scene_folder_tmp/povray.pov Output_File_Name=/tmp/"+@job.partial_image_file_name+" 2>error.txt") 
        @output.puts 'Povray render completed'        
      else
        @output.puts 'Povray command failed.'
        error_message = ''
        File.open("error.txt","r") do |f|
          f.each_line do |line|
            error_message += line
          end        
        end
        @output.puts error_message
      end
    end                       
  end  
end