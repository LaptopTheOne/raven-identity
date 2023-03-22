# frozen_string_literal: true

require 'net/http'
require 'json'

# API for handling Authorization token, Code responses and Bearer token for scopes
class RedirectApi < ::ApplicationApi
  ACCESS_TOKEN_URL = 'https://www.reddit.com/api/v1/access_token/'
  CLINET_ID = 'czvYTXd2rhLhn0G-u3g-wQ'
  CLINET_SECRET = 'isnRW-KVYbHSbyiEs0iBDUevfqE5sw'
  REDIRECT_URI = 'http://localhost:3000/api/redirect/response'
  API_URL = 'https://oauth.reddit.com'
  API_ME = '/api/v1/me'

  # RESPONSE_TYPE = 'code'
  # STATE = 'RANDOM_STRING'
  # DURATION = 'permanent'

  # SCOPE_IDENTITY = 'identity'
  # SCOPE_HISTORY = 'history'

  helpers do
    def generate_token_params(code)
      URI.encode_www_form({
                            'code' => code,
                            'redirect_uri' => REDIRECT_URI,
                            'grant_type' => 'authorization_code'
                          })
    end
  end

  resource :response do
    get do
      code = params['code']
      uri = URI(ACCESS_TOKEN_URL)
      req = Net::HTTP::Post.new(uri)
      req.basic_auth CLINET_ID, CLINET_SECRET
      req['Content-Type'] = 'application/x-www-form-urlencoded'
      req['user-agent'] = 'webapp:raven-web v0.121 (by /u/LaptopTheOne)'
      req.body = generate_token_params(code)

      result = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end

      response = JSON.parse(result.body)
      access_token = response['access_token']
      refresh_token = response['refresh_token']
      expires_in = response['expires_in']
      scope = response['scope']

      puts response

      case scope
      when 'identity'
        redirect("http://localhost:8080?identity-access-token=#{access_token}")
      when 'history'
        redirect("http://localhost:8080?history-access-token=#{access_token}")
      end
    end
  end
end
