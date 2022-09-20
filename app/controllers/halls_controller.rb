class HallsController < ApplicationController
  # Gett all halls
  def halls_list
    if admin?
      render json: Hall.all, each_serializer: HallSerializer
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  # Delete Hall by id
  def delete_hall
    if admin?
      hall = Hall.find(params.permit(:id)[:id])
      raise ActiveRecord::RecordNotFound unless hall

      check_reservations(hall)
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  # Create New Hall
  def add_hall
    if admin?
      hall = current_user.hall.new(halls_params)
      if hall.save
        render json: { created: hall }
      else
        render json: { error: 'Bad Request' }, status: :not_acceptable
      end
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  def edit
    if admin?
      hall = Hall.find(params.permit(:id)[:id])
      raise ActiveRecord::RecordNotFound unless hall

      render json: hall
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  # Update existant Hall by id
  def update_hall
    if admin?
      hall = Hall.find(params.permit(:hall_id)[:hall_id])
      raise ActiveRecord::RecordNotFound unless hall

      hall.update(halls_params)
      if hall.save
        render json: { updated: hall }
      else
        render json: { error: 'Bad Request' }, status: :not_acceptable
      end
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  private

  # Check if hall have any confirmed reservation
  def check_reservations(hall)
    @check = Reservation.where(hall_id: hall.id, status: 'Confirmed')
    if @check.blank?
      if hall.destroy
        render json: { message: "#{hall.name} Hall (ID# #{hall.id}) has been deleted" }
      else
        render json: { message: 'Hall Cannot be deleted : 500 SERVER ERROR' }, status: :not_implemented
      end
    else
      render json: { message: 'You Cannot Delete a Hall with a confirmed reservation' }, status: :unprocessable_entity
    end
  end

  def halls_params
    params.permit(:name, :capacity, :cost, :description, :image)
  end
end
