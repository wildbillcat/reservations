class RequestedReservation < ActiveRecord::Base
  include ReservationValidations

  belongs_to :last_updated_by, :class_name => 'User'

  validates :reserver,
            :start_date,
            :due_date,
            :equipment_model,
            :presence => true

  validate :not_in_past?, :not_empty?, :start_date_before_due_date?
end
