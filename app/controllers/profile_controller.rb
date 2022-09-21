class ProfileController < ApplicationController
  def update
    if logged_in?
      user = current_user
      if user.update!(profile_params)
        render json: { updated: current_user }
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
