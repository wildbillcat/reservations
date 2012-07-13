class AddAuthProviderForAppConfigs < ActiveRecord::Migration
  def change
    add_column :app_configs, :auth_provider, :string
  end
end
