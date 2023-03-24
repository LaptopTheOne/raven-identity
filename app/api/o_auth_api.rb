# frozen_string_literal: true

require 'net/http'
require 'json'

# API for handling Authorization token, Code responses and Bearer token for scopes
class OAuthApi < ::ApplicationApi
  REDDIT_API_URL_AUTH = 'https://www.reddit.com/api/v1/authorize'
  RESPONSE_TYPE = 'code'
  STATE = 'RANDOM_STRING'
  DURATION = 'permanent'

  SCOPE_IDENTITY = 'identity'
  SCOPE_HISTORY = 'history'

  helpers do
    def generate_scope_auth_url(scope)
      "#{REDDIT_API_URL_AUTH}?client_id=#{ENV['client_id']}&"\
      "response_type=#{RESPONSE_TYPE}&"\
      "state=#{STATE}&"\
      "redirect_uri=#{ENV['redirect_uri']}&"\
      "duration=#{DURATION}&scope=#{scope}"
    end
  end

  params do
    optional :scope, type: String
  end
  resource :authorization_token do
    get do
      scope = params[:scope]
      generate_scope_auth_url(scope)
    end
  end
end
