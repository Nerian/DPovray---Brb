#!/usr/bin/env ruby


# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__) 
require 'worker_node'                        

worker = Worker::Worker.new() 
job = Job::Job.new('project_name', '-w320 -h120', 'povray.pov', 'partial_image_file_name')
project_server = ProjectServer::ProjectServer.new       
worker.add_job(job.serialize(), project_server)                                                                  
worker.retrieve_pov_file_from_server()
worker.povray_start_render()
worker.send_rendered_image_to_job_requester()