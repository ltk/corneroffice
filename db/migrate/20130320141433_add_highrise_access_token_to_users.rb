class AddHighriseAccessTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :highrise_access_token, :string, :limit => 400
  end
end
