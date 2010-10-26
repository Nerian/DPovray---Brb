# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc   

module Worker    
      
  # The Worker class represent a Render Node in the Cluster. 
  # A Render Node responsability is to render scenes according 
  # to specific options and send back the image.

  class Worker
    
    attr_accessor :project_server, :job, :output, :id        
        
    def initialize(output=STDOUT, id) 
      @output = output              
      @id = id
    end
        
    def add_job(serialized_job, project_server=nil)      
      
      # This is for testing purposes. The arg project_server will be a mock object. Normally, the project_server will
      # be obtained from the Job information.
      if not project_server.nil?
        @project_server = project_server
      end        
        
      @output.puts 'Received a new Job'  
                                       
      @output.puts 'Unmarshaling the Object...'
      @job = Job::Job.deserialize(serialized_job)
      
      if @job.instance_of? Job::Job                  
        @output.puts 'Unmarshaling completed'
      else
        @output.puts 'Error: Failed to Unmarshal de Job'
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
          @output.puts 'Error: Failed to unmarshal marshaled povray scene file'
        else          
          @output.puts 'Pov file succefully unmarshaled'
          file = File.open("/tmp/povray.pov","w") do |f|
            f.puts povray_scene_file                                  
          end
          if File.exist?("/tmp/povray.pov")
            @output.puts "Pov file saved to temporal file"
          else
            @output.puts "Error: Pov file wasn't saved to temporal file"
          end          
        end
      end
    end          
      
    def povray_start_render()
      @output.puts "Povray render process started"
      if system("povray "+@job.povray_arguments+" +FN -GAfile /tmp/povray.pov Output_File_Name=/tmp/"+@job.partial_image_file_name+" 2>/tmp/error") 
        @output.puts "Povray command was run"
        if File.exist?("/tmp/#{@job.partial_image_file_name}.png")
          @output.puts "Partial image was rendered successfully"
        else
          @output.puts "Error: Partial image was NOT rendered succefully"
        end       
      else
        @output.puts "Error: Povray command failed."
        error_message = ''
        File.open("/tmp/error","r") do |f|
          f.each_line do |line|
            error_message += line
          end        
        end
        @output.puts error_message
      end
    end
    
    def send_rendered_image_to_job_requester()         
      @output.puts("Connection with server stablished")
      
      if @project_server.put(Marshal.dump(@job), Marshal.dump(partial_image_file)) == true
        @output.puts("Image successfully sent")
      else
        @output.puts("Error: Failure while sending the file")
      end
      
    end
    
    def partial_image_file
      if File.exist?("/tmp/#{@job.partial_image_file_name}.png")
        partial_image = ''
        file = File.open("/tmp/#{@job.partial_image_file_name}.png","r")
        file.each_line do |line| 
          partial_image +=line
        end
        file.close
        return partial_image
      else
        @output.puts("Error: Image file wasn't found")
      end
    end

  end  
end