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
      @session.get do |req|
        req.url 'logs/search'
        req.params = {q: query, from: from_time, to: to_time, tz: time_zone}
      end    
    end

    def search_job(query, from_time=nil, to_time=nil, time_zone='UTC')
      params = {query: query, from: from_time, to: to_time, timeZone: time_zone}
      @session.post do |req|
        req.url 'search/jobs'
        req.body = MultiJson.encode(params)
      end
    end

    def search_job_status(search_job={})
      @session.get "search/jobs/#{search_job['id']}"
    end

    def search_job_messages(search_job, limit=nil, offset=0)
      params = {limit: limit, offset: offset}
      @session.get "search/jobs/#{search_job['id']}/messages", params
    end

    def search_job_records(search_job, limit=nil, offset=0)
      params = {limit: limit, offset: offset}
      @session.get "search/jobs/#{search_job['id']}/records", params
    end

    def collectors(limit=nil, offset=nil)
      @session.get 'collectors', {limit: limit, offset: offset}
    end

    def collector(collector_id)
      @session.get "collectors/#{collector_id}"
    end

    def update_collector(collector, etag)
      @session.put do |req|
        req.url "collectors/#{collector['collector']['id']}"
        req.headers['If-Match'] = etag
        req.body = collector
      end
    end

    def delete_collector(collector)
      @session.delete "collectors/#{collector['id']}"
    end

    def sources(collector_id, limit=nil, offset=nil)
      params = {limit: limit, offset: offset}
      @session.get "collectors/#{collector_id}", params
    end

    def source(collector_id, source_id)
      @session.get "collectors/#{collector_id}/sources/#{source_id}"
    end

    def update_source(collector_id, source, etag)
      @session.put do |req|
        req.url "collectors/#{collector_id}/sources/#{source['source']['id']}"
        req.headers['If-Match'] = etag
        req.body = source
      end
    end

    def delete_source(collector_id, source)
      @session.delete "collectors/#{collector_id}/sources/#{source['source']['id']}"
    end

    def create_content(path, data)
      @session.post "content/#{path}", data
    end

    def get_content(path)
      @session.get "content/#{path}"
    end

    def delete_content(path)
      @session.delete "content/#{path}"
    end

    def dashboards(monitors=false)
      r = @session.get 'dashboards', {dashboards: monitors}
      return r.body.has_key?('dashboards') ? r.body['dashboards'] : nil
    end

    def dashboard(dashboard_id)
      r = @session.get "dashboards/#{dashboard_id}"
      return r.body.has_key?('dashboard') ? r.body['dashboard'] : nil
    end

    def dashboard_data(dashboard_id)
      r = @session.get "dashboards/#{dashboard_id}/data"
      return r.body.has_key?('dashboardMonitorDatas') ? r.body['dashboardMonitorDatas'] : nil
    end

  end
end
