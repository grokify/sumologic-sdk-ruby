require 'faraday'
require 'faraday/follow_redirects'
require 'faraday-cookie_jar'
require 'multi_json'

module SumoLogic
  VERSION = '0.1.2'
  URL = 'https://api.sumologic.com/api/v1'

  class Client
    attr_accessor :http

    def initialize(access_id=nil, access_key=nil, endpoint=SumoLogic::URL)
      @endpoint = endpoint
      headers = {'Content-Type' => 'application/json', 'Accept' => 'application/json'}
      @http = Faraday.new(url: @endpoint, headers: headers) do |conn|
        conn.use      Faraday::FollowRedirects::Middleware, limit: 5
        conn.use      :cookie_jar
        conn.request  :authorization, :basic, access_id, access_key
        conn.request  :json
        conn.response :json, content_type: 'application/json'
        conn.adapter  Faraday.default_adapter
      end
    end

    def post(path, data={})
      @http.post do |req|
        req.url path
        req.body = data unless data.empty?
      end
    end

    def search(query, from_time=nil, to_time=nil, time_zone='UTC')
      @http.get do |req|
        req.url 'logs/search'
        req.params = {q: query, from: from_time, to: to_time, tz: time_zone}
      end
    end

    def search_job(query, from_time=nil, to_time=nil, time_zone='UTC')
      params = {query: query, from: from_time, to: to_time, timeZone: time_zone}
      @http.post do |req|
        req.url 'search/jobs'
        req.body = MultiJson.encode(params)
      end
    end

    def search_job_status(search_job={})
      @http.get "search/jobs/#{search_job['id']}"
    end

    def search_job_messages(search_job, limit=nil, offset=0)
      @http.get "search/jobs/#{search_job['id']}/messages", params_limit_offset(limit, offset)
    end

    def search_job_records(search_job, limit=nil, offset=0)
      @http.get "search/jobs/#{search_job['id']}/records", params_limit_offset(limit, offset)
    end

    def collectors(limit=nil, offset=nil)
      @http.get 'collectors', params_limit_offset(limit, offset)
    end

    def collector(collector_id)
      @http.get "collectors/#{collector_id}"
    end

    def update_collector(collector, etag)
      @http.put do |req|
        req.url "collectors/#{collector['collector']['id']}"
        req.headers['If-Match'] = etag
        req.body = collector
      end
    end

    def delete_collector(collector)
      @http.delete "collectors/#{collector['id']}"
    end

    def sources(collector_id, limit=nil, offset=nil)
      @http.get "collectors/#{collector_id}/sources", params_limit_offset(limit, offset)
    end

    def source(collector_id, source_id)
      @http.get "collectors/#{collector_id}/sources/#{source_id}"
    end

    def update_source(collector_id, source, etag)
      @http.put do |req|
        req.url "collectors/#{collector_id}/sources/#{source['source']['id']}"
        req.headers['If-Match'] = etag
        req.body = source
      end
    end

    def delete_source(collector_id, source)
      @http.delete "collectors/#{collector_id}/sources/#{source['source']['id']}"
    end

    def create_content(path, data)
      @http.post "content/#{path}", data
    end

    def get_content(path)
      @http.get "content/#{path}"
    end

    def delete_content(path)
      @http.delete "content/#{path}"
    end

    def dashboards(monitors=false)
      r = @http.get 'dashboards', {dashboards: monitors}
      return r.body.key?('dashboards') ? r.body['dashboards'] : nil
    end

    def dashboard(dashboard_id)
      r = @http.get "dashboards/#{dashboard_id}"
      return r.body.key?('dashboard') ? r.body['dashboard'] : nil
    end

    def dashboard_data(dashboard_id)
      r = @http.get "dashboards/#{dashboard_id}/data"
      return r.body.key?('dashboardMonitorDatas') ? r.body['dashboardMonitorDatas'] : nil
    end

    def params_limit_offset(limit, offset)
      params = {}
      params[:limit] = limit unless limit.nil?
      params[:offset] = offset unless offset.nil?
      params
    end
  end
end
