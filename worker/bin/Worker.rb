#!/usr/bin/env ruby
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__) 
require 'worker_node'                        

worker = Worker::Worker.new() 
job = Job::Job.new('project_name', '-w320 -h120', 'povray.pov', 'partial_image_file_name')       

worker.add_job(job.serialize())