class AddColumnsToAppConfigs < ActiveRecord::Migration
  def change
   change_table :app_configs do |t|
      t.string :auth_provider
      t.string :ldap_host
      t.integer :ldap_port
      t.string :ldap_login
      t.string :ldap_base_query
      t.string :ldap_first_name
      t.string :ldap_last_name
      t.string :ldap_phone
      t.string :ldap_email
    end
  end
end
