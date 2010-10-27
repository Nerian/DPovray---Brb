# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc

module Job
  class Job     
    
    attr_accessor :id, :povray_arguments
    
    def initialize(id, povray_arguments)      
      @povray_arguments = povray_arguments
      @id = id
    end  
    
    def serialize
      Marshal.dump(self)
    end
    
    def self.deserialize(serialized_job)
      Marshal.load(serialized_job)
    end
                                                              
  end
end