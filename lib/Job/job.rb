# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc

module Job
  class Job     
    
    attr_accessor :project_name, :povray_arguments, :povray_scene_file_name, :partial_image_file_name
    
    def initialize(id, povray_arguments, povray_scene_file_name)      
      @project_name = project_name
      @povray_arguments = povray_arguments
      @povray_scene_file_name = povray_scene_file_name 
      @partial_image_file_name = id
    end  
    
    def serialize
      Marshal.dump(self)
    end
    
    def self.deserialize(serialized_job)
      Marshal.load(serialized_job)
    end
                                                              
  end
end