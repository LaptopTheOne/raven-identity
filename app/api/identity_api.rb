# frozen_string_literal: true

require 'net/http'
require 'json'

# API for handling Identity API calls
class IdentityApi < ::ApplicationApi
  API_URL = 'https://oauth.reddit.com'
  API_ME = '/api/v1/me'

  helpers do
  end

  resource :me do
    get do
      access_token = params['token']
      uri = URI(API_URL + API_ME)
      req = Net::HTTP::Get.new(uri)
      req['Authorization'] = "Bearer #{access_token}"
      result = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end

      JSON.parse(result.body)
    end
  end
end
