require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'
require 'multi_json'

module SumoLogic

  URL = 'https://api.sumologic.com/api/v1'

  class Client

    def initialize(accessId=nil, accessKey=nil, endpoint=SumoLogic::URL)
      @endpoint = endpoint
      @session  = Faraday
      headers   = {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
      @session  = Faraday.new(:url => @endpoint, :headers => headers) do |conn|
        conn.basic_auth(accessId, accessKey)
        conn.use      :cookie_jar
        conn.request  :json
        conn.response :json, :content_type => 'application/json'
        conn.adapter  Faraday.default_adapter
      end
    end

    def search_job(query, fromTime=nil, toTime=nil, timeZone='UTC')
      params = {:query => query, :from => fromTime, :to => toTime, :timeZone => timeZone}
      r = @session.post do |req|
        req.url 'search/jobs'
        req.body = MultiJson.encode(params)
      end
    end

    def search_job_status(search_job={})
      r = @session.get do |req|
        req.url 'search/jobs/' + search_job['id'].to_s
      end
    end
    
    def search_job_records(search_job, limit=nil, offset=0)
      params = {:limit => limit, :offset => offset}
      r = @session.get do |req|
        req.url 'search/jobs/' + search_job['id'].to_s + '/records'
        req.params = params
      end
    end

  end

end
