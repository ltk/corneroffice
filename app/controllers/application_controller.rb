class ApplicationController < ActionController::Base
  protect_from_forgery
  include SimplestAuth::Controller
  
  private

  def set_highrise_access_token
     Highrise::Base.oauth_token = current_user.highrise_access_token
  end

  def token_options
    {
    :client_secret => Highrise::ClientSecret,
    :client_id     => Highrise::ClientId,  
    :redirect_uri  => "http://corneroffice.dev/user/new",
    }
  end
end
