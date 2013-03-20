require "spec_helper"
require 'oauth2/strategies/web_server'

describe OAuth2::Strategy::WebServer do
  describe "#authorize_params" do
    it "sets up old school (draft 5) oauth2 params" do
      client = double(:client)
      client.stub(:id) { 1 }
      described_class.new(client).authorize_params.should == { 'type' => 'web_server', 'client_id' => 1 }
    end
  end
end
