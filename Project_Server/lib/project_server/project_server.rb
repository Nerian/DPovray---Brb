
module ProjectServer  
  
  # The Project_Server class represent  the Project Server Component, whose 
  # responsability is to manage Projects, distribute Jobs
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

    def put(marshaled_job, marshaled_image_file)
      image_file_string = Marshal.load(marshaled_image_file)
      job = Marshal.load(marshaled_job)
      if image_file_string.size == 0 or job.nil?        
        false
      else          
        true
      end
    end
  end
  
end
