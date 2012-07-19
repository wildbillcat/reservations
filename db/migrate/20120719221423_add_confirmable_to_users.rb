class AddConfirmableToUsers < ActiveRecord::Migration
  def up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime

    User.update_all(:confirmed_at => Time.now)

    remove_column :users, :provider, :uid

    add_index :users, :confirmation_token, :unique => true
  end

  def down
    remove_column :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
