# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc

module Job
  class Job
    @project_name
    @povray_arguments
    @povray_scene_file_name
    @partial_image_file_name
    
    def initialize(project_name, povray_arguments, povray_scene_file_name, partial_image_file_name)      
      @project_name = project_name
      @povray_arguments = povray_arguments
      @povray_scene_file_name = povray_scene_file_name 
      @partial_image_file_name = partial_image_file_name
    end  
    
    def serialize
      Marshal.dump(self)
    end
    
    def self.deserialize(serialized_job)
      Marshal.load(serialized_job)
    end
    
    def project_name
      @project_name            
    end            
    
    def povray_arguments
      @povray_arguments
    end                
    
    def povray_scene_file_name
      @povray_scene_file_name
    end                      
    
    def partial_image_file_name
      @partial_image_file_name
    end  
                                                  
  end
end