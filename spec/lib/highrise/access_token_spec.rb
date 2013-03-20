require "spec_helper"
require "highrise/access_token"
require "oauth2/strategies/web_server"

describe Highrise::AccessToken do
  subject { described_class.new(:client_id => "CLIENT-ID",
                                :redirect_uri => "http://corneroffice.dev/user/new") }

  its(:authorize_url) { should == "https://launchpad.37signals.com/authorization/new?type=web_server&client_id=CLIENT-ID&redirect_uri=http%3A%2F%2Fcorneroffice.dev%2Fuser%2Fnew" }

  describe "#token" do
    context "with valid credentials" do
      it "returns a long string" do
        VCR.use_cassette "highrise_access_token", :record => :none do
          subject.token.should == "big-long-token"
        end
      end
    end
    
    context "with invalid credentials" do
      it "returns a long string" do
        VCR.use_cassette "error_highrise_access_token", :record => :none do
          lambda{ subject.token }.should raise_error(OAuth2::Error)
        end
      end
    end
  end
end
