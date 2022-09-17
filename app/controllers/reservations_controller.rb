class ReservationsController < ApplicationController
    #Get All Reservations With Status Pending
    def get_pending_reservation_admin
        if admin?
            pending_reservations = Reservation.all.where(status:'Pending')
            render json: pending_reservations, each_serializer: ReservationSerializer
        else
            render json: { error: 'Not Allowed' }, status: :unauthorized
        end
    end

    #Update a Reservation Based On Admin Decision
    def handle_pending_reservation_admin
        if admin?
            reservation = Reservation.find_by(id: action_params[:reservation_id].to_i)
            raise ActiveRecord::RecordNotFound if !reservation
            if action_params[:decision] == 'Confirm'
            accept_reservation(reservation)
            elsif action_params[:decision] == 'Refuse'
            refuse_reservation(reservation)
             end
             else
            render json: { error: 'Not Allowed' }, status: :unauthorized
             end
    end

  

    def action_params
        params.permit(:reservation_id, :decision, :text)
      end
end
