class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :login
      t.string :password_digest

      t.timestamps
    end
  end
end
