class ReservationsController < ApplicationController
  # Get All Reservations With Status Pending
  def pending_reservation_admin
    if admin?
      pending_reservations = Reservation.all.where(status: 'Pending')
      render json: pending_reservations, each_serializer: ReservationSerializer
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  # Update a Reservation Based On Admin Decision
  def handle_pending_reservation_admin
    if admin?
      reservation = Reservation.find_by(id: action_params[:reservation_id].to_i)
      raise ActiveRecord::RecordNotFound unless reservation

      case action_params[:decision]
      when 'Confirm'
        accept_reservation(reservation)
      when 'Refuse'
        refuse_reservation(reservation)
      end
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  private

  # If Admin Approve Update reservation status
  def accept_reservation(reservation)
    reservation.status = 'Confirmed'
    if reservation.save
      create_notification(reservation)
      render json: reservation, each_serializer: ReservationSerializer
    else
      render json: { error: 'Bad Request' }, status: :not_acceptable
    end
  end

  # If Admin Refuse Update reservation status
  def refuse_reservation(reservation)
    reservation.status = 'Refused'
    if reservation.save
      create_notification(reservation)
      render json: reservation, each_serializer: ReservationSerializer
    else
      render json: { error: 'Bad Request' }, status: :not_acceptable
    end
  end

  # After every decision Add Notification to database & Send Email
  def create_notification(reservation)
    current_user.notifier.create(recipient_id: reservation.user_id, admin_id: current_user.id,
                                 text: action_params[:text], reserve_id: reservation.id)
    # Send Email Later
  end

  def action_params
    params.permit(:reservation_id, :decision, :text)
  end
end
