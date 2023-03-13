# frozen_string_literal: true

# Root Grape API class
class RootApi < ::ApplicationApi
  PREFIX = '/api'

  mount ::OAuthApi => "#{PREFIX}/oauth"
  mount ::RedirectApi => "#{PREFIX}/redirect"
  mount ::IdentityApi => "#{PREFIX}/identity"
end
