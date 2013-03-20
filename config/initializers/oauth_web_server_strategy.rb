require 'oauth2/strategies/web_server'

module OAuth2
  class Client
     def web_server
      @web_server ||= OAuth2::Strategy::WebServer.new(self)
    end
  end
end