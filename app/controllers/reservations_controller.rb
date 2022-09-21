class ReservationsController < ApplicationController
  # Create a reservation for a hall
  def create
    if logged_in?
      check_date
    else
      render json: { error: 'Please log in to make a reservation' }, status: :unauthorized
    end
  end

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
        update_reservation(reservation, 'Confirmed')
      when 'Refuse'
        update_reservation(reservation, 'Refused')
      end
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  # create my reservations for a user
  def my_reservations
    return render json: { error: 'You need to loginto access this page' }, status: :unauthorized unless logged_in?

    @reservations = current_user.reservations.all
    raise ActiveRecord::RecordNotFound unless @reservations

    render json: @reservations, each_serializer: ReservationSerializer, status: :ok
  end

  def available_halls
    check = Reservation.select(:hall_id).where(reserve_date: reservation_params[:reserve_date], status: 'Confirmed')
    unavailable = []
    check.each { |hall| unavailable << hall.hall_id }
    @halls = Hall.all
    available = @halls.select {|hall| !(unavailable.include?(hall.id))}
    render json: { available: }
    
  end

  # delete reservation
  def delete_reservation
    if logged_in?
      @reservation = current_user.reservations.find(params[:reservation_id])
      raise ActiveRecord::RecordNotFound unless @reservation

      if @reservation.status == 'Pending'
        if @reservation.destroy
          render json: { message: 'reservation deleted' }, status: :ok
        else
          render json: { error: 'Reservation can\'t be destroyed' }, status: :not_implemented
        end
      else
        render json: { error: 'You can not delete this reservation' }, status: :unauthorized
      end
    else
      render json: { error: 'You need to login to access this page' }, status: :unauthorized
    end
  end

  private

  # If Admin Approve Update reservation status
  def update_reservation(reservation, decision)
    reservation.status = decision
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

  def check_date
    # check if hall is available for the date
    @check = Reservation.where(hall_id: reservation_params[:hall_id],
                               reserve_date: reservation_params[:reserve_date], status: 'Confirmed')
    if @check.blank?
      create_reservation
    else
      render json: { message: 'Hall Unavailable on this date' }, status: :unprocessable_entity
    end
  end

  def create_reservation
    @reservation = current_user.reservations.new(hall_id: reservation_params[:hall_id],
                                                 reserve_date: reservation_params[:reserve_date], status: 'Pending')
    if @reservation.save
      render json: { message: 'reservation created', status: :created }
    else
      render json: { message: 'reservation not created' }, status: :unprocessable_entity
    end
  end

  def reservation_params
    params.permit(:hall_id, :reserve_date)
  end

  def action_params
    params.permit(:reservation_id, :decision, :text)
  end
end
