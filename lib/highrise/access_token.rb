require 'oauth2/strategies/web_server'

module Highrise
  class AccessToken
    def initialize(options)
      @state              = options.delete(:state)
      @client_id          = options.delete(:client_id)
      @client_secret      = options.delete(:client_secret)
      @redirect_uri       = options.delete(:redirect_uri)
      @authorization_code = options.delete(:authorization_code)
    end

    def authorize_url
      client.web_server.authorize_url({
        :redirect_uri  => @redirect_uri
      })
    end

    def client
      OAuth2::Client.new(@client_id, @client_secret, {
          :authorize_url => '/authorization/new',
          :token_url     => '/authorization/token',
          :site          => 'https://launchpad.37signals.com/'
      })
    end

    def token
      # VCR.use_cassette('highrise_access_token') do
        client.web_server.get_token(@authorization_code,
          { 
            "type"   => "web_server",
            "redirect_uri" => @redirect_uri
          }
        ).token
      # end
    end

    def authorization_code
      @user.oauth2_authorization_code
    end
  end
end
