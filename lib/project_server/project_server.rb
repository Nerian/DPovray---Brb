
module ProjectServer  
  
  # The Project_Server class represent  the Project Server Component, whose 
  # responsability is to manage Projects, distribute Jobs
  class ProjectServer         
    def find_pov_file(name)
      povray_scene_string = ''
      file = File.new("povray.pov","r")
      file.each_line do |line| 
        povray_scene_string +=line
      end
      file.close
      marshaled_povray_scene_file = Marshal.dump(povray_scene_string)
    end

    def put(marshaled_job, marshaled_image_file)      
      image_file_string = Marshal.load(marshaled_image_file)
      job = Marshal.load(marshaled_job)
      return_value = nil
      if image_file_string.size == 0 or job.nil?        
        return_value = false
        puts "Error: Received 'put' order to register a completed job, but either Image or Job was corrupted"
      else          
        return_value = true        
      end
      return return_value
    end
  end
  
end
