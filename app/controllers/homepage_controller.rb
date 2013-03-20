class HomepageController < ApplicationController
  def show
    @token = Highrise::AccessToken.new(token_options)
  end
end
