class CreateRequestedReservations < ActiveRecord::Migration
  def up
    create_table :requested_reservations do |t|
      t.references :reserver
      t.datetime :start_date
      t.datetime :due_date
      t.references :equipment_model
      t.string :approval_status
      t.string :reason
      t.string :notes
      t.references :last_updated_by
      t.timestamps
    end
  end

  def down
    drop_table :requested_reservations
  end
end