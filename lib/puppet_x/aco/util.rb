module PuppetX
  module Aco
    module Util

      require 'net/http'

      def self.request(uri_str, method = nil, cookies = [], proxy_addr = nil, proxy_port = nil, limit = 10)
        raise ArgumentError, 'too many HTTP redirects' if limit == 0

        uri = URI(uri_str)

        case method
        when 'POST' then
        reqmethod = Net::HTTP::Post
        when 'HEAD' then
        reqmethod = Net::HTTP::Head
        else
        reqmethod = Net::HTTP::Get
        end

        request = reqmethod.new(uri.request_uri, {'user-agent' => 'Mozilla/5.0 (Puppet)', 'cookie' => cookies.join('; ')})
        response = Net::HTTP.start(uri.host, uri.port, proxy_addr, proxy_port, :use_ssl => uri.scheme == 'https') do |http|
          http.request(request)
        end

        # cache cookies for subsequent requests
        response_cookies = response.get_fields('set-cookie')
        if !response_cookies.nil?
          response_cookies.each { |c| cookies.push(c.split('; ')[0]) }
        end

        case response
        when Net::HTTPSuccess then
          return uri, response, cookies
        when Net::HTTPRedirection then
          location = response['location']
          request(location, method = method, cookies, proxy_addr, proxy_port, limit - 1)
        else
          return response.value, nil
        end
      end

    end
  end
end
