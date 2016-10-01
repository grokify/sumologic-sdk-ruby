require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'
require 'multi_json'

module SumoLogic
  VERSION = '0.0.5'
  URL = 'https://api.sumologic.com/api/v1'

  class Client

    def initialize(access_id=nil, access_key=nil, endpoint=SumoLogic::URL)
      @endpoint = endpoint
      @session  = Faraday
      headers   = {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
      @session  = Faraday.new(url: @endpoint, headers: headers) do |conn|
        conn.basic_auth(access_id, access_key)
        conn.use      :cookie_jar
        conn.request  :json
        conn.response :json, content_type: 'application/json'
        conn.adapter  Faraday.default_adapter
      end
    end

    def search(query, from_time=nil, to_time=nil, time_zone='UTC')
      params = {q: query, from: from_time, to: to_time, tz: time_zone}
      r = @session.get do |req|
        req.url 'logs/search'
        req.params = params
      end    
    end

    def search_job(query, from_time=nil, to_time=nil, time_zone='UTC')
      params = {query: query, from: from_time, to: to_time, timeZone: time_zone}
      r = @session.post do |req|
        req.url 'search/jobs'
        req.body = MultiJson.encode(params)
      end
    end

    def search_job_status(search_job={})
      r = @session.get do |req|
        req.url "search/jobs/#{search_job['id']}"
      end
    end

    def search_job_messages(search_job, limit=nil, offset=0)
      params = {limit: limit, offset: offset}
      r = @session.get do |req|
        req.url "search/jobs/#{search_job['id']}/messages"
        req.params = params
      end
    end

    def search_job_records(search_job, limit=nil, offset=0)
      params = {limit: limit, offset: offset}
      r = @session.get do |req|
        req.url "search/jobs/#{search_job['id']}/records"
        req.params = params
      end
    end

    def dashboards(monitors=false)
      params = {dashboards: monitors}
      r = @session.get do |req|
        req.url 'dashboards'
        req.params = params
      end
      return r.body.has_key?('dashboards') ? r.body['dashboards'] : nil
    end

    def dashboard(dashboard_id)
      r = @session.get do |req|
        req.url "dashboards/#{dashboard_id}"
      end
      return r.body.has_key?('dashboard') ? r.body['dashboard'] : nil
    end

    def dashboard_data(dashboard_id)
      r = @session.get do |req|
        req.url "dashboards/#{dashboard_id}/data"
      end
      return r.body.has_key?('dashboardMonitorDatas') ? r.body['dashboardMonitorDatas'] : nil
    end

  end
end
