class RequirementStepsUsersTable < ActiveRecord::Migration
  def self.up
    create_table :requirement_steps_users, :id => false do |t|
      t.integer :requirement_step_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :requirement_steps_users
  end
end