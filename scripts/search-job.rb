#!/usr/bin/env ruby

require 'multi_json'
require 'optparse'
require 'sumologic'
require 'pp'
require 'time'

options = {:query => ''}

OptionParser.new do |opts|
  opts.banner = "Usage: search-job.rb [options]"

  opts.on('-u', '--username ACCESS_ID/USERNAME' , 'Access Id / Username')  { |v| options[:access_id]  = v }
  opts.on('-p', '--password ACCESS_KEY/PASSWORD', 'Access Key / Password') { |v| options[:access_key] = v }
  opts.on('-q', '--query QUERY', 'Query')    { |v| options[:query] = v ? v : '' }
  opts.on('-v', '--verbose BOOL', 'Verbose') { |v| options[:verbose] = v ? true : false }
  opts.on('-o', '--output OUTPUT_PATH', 'Output Path') { |v| options[:output_path] = v ? v : '/tmp/sumo_api_output.json' }
  options[:query].to_s.gsub!(/[\s\n]+/, ' ')
end.parse!

puts options[:query] if options[:verbose]

sdk = SumoLogic::Client.new(options[:access_id], options[:access_key])

ms_now = (Time.now.to_f * 1000).to_i
ms_30daysago = ms_now - 60*60*24*15*1000

res = sdk.search_job(options[:query], ms_30daysago, ms_now)

pp(res.body) if options[:verbose]

sj = res.body

res = sdk.search_job_status(sj)
status = res.body

delay = 2
puts status['state'] if options[:verbose]

while status['state'] != 'DONE GATHERING RESULTS' do
  if status['state'] == 'CANCELLED'
    break
  end
  sleep(delay)
  delay *= 2
  res = sdk.search_job_status(sj)
  status = res.body
  pp status if options[:verbose]
end

limit = 200

if status['state'] == 'DONE GATHERING RESULTS'
  count = status['recordCount'].to_i
  limit = (count < limit) ? count : limit # compensate bad limit check
  res = sdk.search_job_records(sj, limit)
  pp(res.body)
  bodyJson = MultiJson.encode(res.body)
  out_file = options[:output_path]
  File.open(out_file,'w') do |fh|
    fh.puts bodyJson
  end
  puts "WROTE #{options[:output_path]}" if options[:verbose]
end
