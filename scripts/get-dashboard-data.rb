#!/usr/bin/env ruby

# Get all dashboard data
#
# ruby get-dashboard-data.rb --id <accessId/email> --key <accessKey/password>

require 'optparse'
require 'pp'
require 'sumologic'

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: search-job.rb [options]"
  opts.on('-i', '--id ACCESS_ID/USERNAME' , 'Access Id / Username')  { |v| options[:access_id]  = v }
  opts.on('-k', '--key ACCESS_KEY/PASSWORD', 'Access Key / Password') { |v| options[:access_key] = v }
end.parse!

sumo = SumoLogic::Client.new(options[:access_id], options[:access_key])

ds = sumo.dashboards()
pp ds