class UsersController < ApplicationController
  before_filter :load_user, :only => [:new, :edit, :update]
  before_filter :auth_code_missing_failure, :unless => :auth_code_present?, :only => :new
  before_filter :set_highrise_access_token, :unless => :highrise_access_token_present?, :only => :new

  def new
    set_highrise_access_token

    begin
      @user.set_highrise_info(Highrise::User.me)
    rescue
      flash.now[:notice] = "We couldn't retrieve your information from Highrise at this time."
    end
  end

  def create
    @user = User.new params[:user]

    if @user.save
      redirect_to root_path, :notice => "You're signed up!"
    else
      signup_fail_with_message
    end
  end
  
  private

  def load_user
    @user = current_user || User.new
  end

  def signup_fail_with_message(msg = "There were errors with your submission.")
    flash.now[:error] = msg
    render :new and return
  end

  def auth_code_missing_failure
    signup_fail_with_message "No authorization code was provided."
  end

  def auth_code_present?
    params[:code].present?
  end

  def highrise_access_token_present?
    @user.highrise_access_token.present?
  end

  def set_highrise_access_token
    begin
      @user.set_token(token_options.merge(:authorization_code => params[:code]))
      self.current_user = @user
    rescue
      signup_fail_with_message "Invalid authorization code. Try again."
    end
  end
end
