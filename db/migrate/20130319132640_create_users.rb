class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :name

      t.timestamps
    end

    add_index :users, :email, :unique => true
  end
end
