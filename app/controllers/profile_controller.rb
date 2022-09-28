class ProfileController < ApplicationController
  def update
    if logged_in?
      if current_user.update(profile_params)
        render json: { updated: current_user }
      else
        render json: { error: current_user }, status: :not_implemented
      end
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  private

  def profile_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
