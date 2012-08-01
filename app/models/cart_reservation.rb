class CartReservation < ActiveRecord::Base
  include ReservationValidations

  validates :reserver,
            :start_date,
            :due_date,
            :equipment_model,
            :presence => true

  validate :not_in_past?, :not_empty?, :start_date_before_due_date?
end
