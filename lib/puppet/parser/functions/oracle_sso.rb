module Puppet::Parser::Functions
  begin
    require 'puppet_x/aco/util'
  rescue LoadError
    mod = Puppet::Module.find('oracle_java', Puppet[:environment].to_s)
    require File.join mod.path, 'lib/puppet_x/aco/util'
  end

  newfunction(:oracle_sso, :type => :rvalue) do |args|
    fileuri = args[0]
    ssousername = args[1]
    password = args[2]
    proxy_server = args[3]
    proxy_type = args[4]

    if proxy_server
      proxy_uri = URI(proxy_server)
      unless proxy_uri.scheme
        proxy_uri = URI("#{proxy_type}://#{proxy_server}")
      end
      proxy_addr = proxy_uri.hostname
      proxy_port = proxy_uri.port
    end

    cookies = ['oraclelicense=accept-securebackup-cookie']

    #
    # Step 1: try unauthenticated download from given URI
    # Success: URI contains AuthParam parameter and HEAD request returns 200
    # Failure: 404 or redirect to Oracle SSO
    #

    begin
      uri, _, _ = PuppetX::Aco::Util.request(fileuri, 'HEAD', cookies)
      if uri.host == 'login.oracle.com'
        debug("Authentication required for #{fileuri}")
      elsif uri.query and uri.query.include?('AuthParam=')
        debug("Authentication not required for #{fileuri}")
        return uri.to_s
      else
        raise "Unknown failure while fetching #{fileuri}"
      end
    rescue Net::HTTPServerException => e
      debug("File not found at #{fileuri}")
      debug('Trying authenticated download...')
      fileuri = fileuri.gsub!('otn-pub', 'otn')
    end

    #
    # Step 2: authenticate against Oracle SSO
    # Success: requested form contains OAM_REQ parameter and POST returns a redirect
    # Failure: POST returns 200 or http error
    #

    # retrieve SSO form and read OAM_REQ parameter value
    debug('Retrieving Oracle.com SSO form.')
    _, response, cookies = PuppetX::Aco::Util.request(fileuri, 'GET', cookies, proxy_addr, proxy_port)
    matchdata = /name="OAM_REQ" value="(.+?)"/.match(response.body)
    if matchdata and !matchdata.captures.nil?
      oamreq = matchdata[1]
      debug('Found OAM_REQ parameter from Oracle.com SSO form.')
    else
      raise 'Could not retrieve OAM_REQ parameter from Oracle.com SSO form.'
    end

    # submit authentication form
    debug('Submitting Oracle.com SSO form.')
    ssouri = URI('https://login.oracle.com/oam/server/sso/auth_cred_submit')
    cookies.push('s_cc=true')

    # begin TODO: pass body to Util.request and enforce no redirect
    request = Net::HTTP::Post.new(ssouri.request_uri, {'user-agent' => 'Mozilla/5.0 (Puppet)', 'cookie' => cookies.join('; ')})
    request.set_form_data('ssousername' => ssousername, 'password' => password)
    request.body += "&OAM_REQ=#{oamreq}"

    response = Net::HTTP.start(ssouri.host, ssouri.port, proxy_addr, proxy_port, :use_ssl => true) { |http| http.request(request) }
    case response
    when Net::HTTPRedirection
      location = response['location']
      if URI(location).request_uri.start_with?('/osso_login_success')
        debug('Sign-on success.')
        response.get_fields('set-cookie').each { |c| cookies.push(c.split('; ')[0]) }
      else
        raise 'Sign-on failed. Check your Oracle.com credentials.'
      end
    else
      raise 'Sign-on failed. Check your Oracle.com credentials.'
    end
    # end TODO

    #
    # Step 3: try authenticated download from transformed URI
    # Success: URI contains AuthParam parameter and HEAD request returns 200
    # Failure: 404 or redirect to Oracle SSO
    #

    begin
      uri, _, _ = PuppetX::Aco::Util.request(location, 'HEAD', cookies, proxy_addr, proxy_port)
      if uri.query and uri.query.include?('AuthParam=')
        return uri.to_s
      else
        raise "Unknown failure while fetching #{fileuri}"
      end
    rescue Net::HTTPServerException => e
      raise "File not found at #{fileuri}"
    end
  end
end
