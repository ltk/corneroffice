class User < ActiveRecord::Base
  include SimplestAuth::Model
  authenticate_by :email

  attr_accessible :email, :name, :password, :password_confirmation, :highrise_access_token

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true
  validates :highrise_access_token, :presence => true
  validates :password, :confirmation => true
  validates :password, :length => { :minimum => 5 }, :if => :password_required?
  validates :password, :presence => true, :on => :create
  validates :password_confirmation, :presence => true, :on => :create

  def set_highrise_info(info)
    self.email = info.email_address
    self.name = info.name
  end

  def set_token(token_options)
    update_attribute(:highrise_access_token, Highrise::AccessToken.new(token_options).token)
  end
end
