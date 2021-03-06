# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc   

module Worker    
      
  # The Worker class represent a Render Node in the Cluster. 
  # A Render Node responsability is to render scenes according 
  # to specific options and send back the image.

  class Worker
    
    attr_accessor :project_server, :job, :output, :id, :tmp_folder        
        
    def initialize(output=STDOUT, id) 
      @output = output              
      @id = id
      @tmp_folder = "/tmp/#{@id}"
      @partial_image_file_path = @tmp_folder+"/partial_image.tga"
      create_folder_structure()
    end       
    
    def create_folder_structure()
      if Dir.exist?(@tmp_folder)
        FileUtils.rm_rf(@tmp_folder)
        FileUtils.mkdir(@tmp_folder)
      else
        FileUtils.mkdir(@tmp_folder)
      end        
    end
    
    def start_your_work(serialized_job)      
      
      core = BrB::Tunnel.create(nil, "brb://localhost:5555")     
      add_job(serialized_job)
      retrieve_pov_file_from_server
      partial_image = povray_start_render      
      core.report(partial_image)        
      sleep(2) 
      cleanup()      
      
    end
        
    def add_job(job, project_server=nil)      
                 
      # This is for testing purposes. The arg project_server will be a mock object. Normally, the project_server will
      # be obtained from the Job information.
      if project_server.nil?
        @project_server = ProjectServer::ProjectServer.new
      end                                                                                                                 
      if job.instance_of? Job::Job                         
        @job = job
      else
        raise "Error: Worker #{@id} received a corrupted job object "
      end
    end  
    
    def retrieve_pov_file_from_server()                         
      #@output.puts 'Asking for .pov file'
      marshaled_povray_scene_file = @project_server.find_pov_file(@job.id)
      if(marshaled_povray_scene_file.nil?)
        #@output.puts 'Failed to receive povray scene file'
      else
        #@output.puts 'Received marshaled .Pov file'
        #@output.puts 'Unmarshaling .pov file'
        povray_scene_file = Marshal.load(marshaled_povray_scene_file)
        if (povray_scene_file.nil?)
          #@output.puts 'Error: Failed to unmarshal marshaled povray scene file'
        else          
          #@output.puts 'Pov file succefully unmarshaled'
          file = File.open("#{tmp_folder}/povray.pov","w") do |f|
            f.puts povray_scene_file                                  
          end
          if File.exist?("#{tmp_folder}/povray.pov")
            #@output.puts "Pov file saved to temporal file"
          else
            #@output.puts "Error: Pov file wasn't saved to temporal file"
          end          
        end
      end
    end          
      
    def povray_start_render()
      if system("povray -SC0.#{@job.starting_column} -EC0.#{@job.ending_column} +FT -GAfile #{tmp_folder}/povray.pov -O#{@partial_image_file_path} 2>#{tmp_folder}/error") 
        if File.exist?(@partial_image_file_path)
          contents = File.open(@partial_image_file_path, 'rb') { |f| f.read }
          return contents
        else
          @output.puts "Error: Partial image was NOT rendered succefully"
        end       
      else
        @output.puts "Error: Povray command failed."
        error_message = ''
        File.open("#{tmp_folder}/error","r") do |f|
          f.each_line do |line|
            error_message += line
          end        
        end
        @output.puts error_message
      end
    end
    
    def send_rendered_image_to_job_requester()         
      #@output.puts("Connection with server stablished")
      
      if @project_server.put(Marshal.dump(@job), Marshal.dump(partial_image_file)) == true
      else
        @output.puts("Error: Failure while sending the file")
      end
      
    end
    
    def partial_image_file
      if File.exist?(@partial_image_file_path)
        partial_image = ''
        file = File.open(@partial_image_file_path,"r")
        file.each_line do |line| 
          partial_image +=line
        end
        file.close
        return partial_image
      else
        @output.puts("Error: Image file wasn't found")
      end
    end
    
    def cleanup()
      if Dir.exist?(@tmp_folder)
        FileUtils.rm_rf(@tmp_folder)
      end
    end

  end  
end