class CreateRequirementSteps < ActiveRecord::Migration
  def change
    create_table :requirement_steps do |t|
      t.integer :requirement_id
      t.text :step
      t.integer :order

      t.timestamps
    end
  end
end
