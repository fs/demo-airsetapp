class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :uid
      t.string :airset_id
      t.string :auth_token
      t.string :session_key
      t.datetime :session_valid_until
      t.string :name
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
