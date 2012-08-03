class RequestedReservation < ActiveRecord::Base
  include ReservationValidations

  belongs_to :last_updated_by, :class_name => 'User'

  validates :reserver,
            :start_date,
            :due_date,
            :equipment_model,
            :presence => true

  validate :not_in_past?, :not_empty?, :start_date_before_due_date?
  
  scope :recent, order('start_date, due_date, reserver_id')
  scope :requested, lambda { where("approval_status IS NULL and due_date >= ?", Time.now.midnight.utc ).recent }
  scope :approved, lambda { where("approval_status = ?", 'approved' ).recent }
  scope :denied, lambda { where("approval_status = ?", 'denied' ).recent }
end
