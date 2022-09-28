class UsersController < ApplicationController
  def create
    if User.find_by_email(user_params[:email])
      render json: { error: 'Email Exist , try a diffrent one' }, status: :not_acceptable
    else
      user = User.new(user_params)
      if user.save
        token = issue_token(user)
        render json: { user: UserSerializer.new(user), jwt: token }
      elsif user.errors.messages
        render json: { error: user.errors.messages }
      else
        render json: { error: 'User could not be created. Please try again' }
      end
    end
  end

  def all_users
    if admin?
      @users = User.where.not(id: current_user.id)
      render json: @users, each_serializer: UserSerializer
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  # Admin can update user info i.e (first_name, last_name, email, password and role)
  def update_user_info
    if admin?
      @user = User.find(update_params[:id])
      if @user.update(update_params)
        render json: { message: 'user updated', status: :updated }
      else
        render json: { message: 'Email already exists' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  # Admin can delete users except itself
  def destroy
    if admin?
      @user = User.find(update_params[:id])
      if @user == current_user
        render json: { message: 'Can not delete current user' }, status: :unprocessable_entity
      elsif @user.destroy
        render json: { message: 'user deleted', status: :destroyed }
      else
        render json: { message: 'user not deleted' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Not Allowed' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end

  def update_params
    params.permit(:id, :first_name, :last_name, :email, :role, :password)
  end
end
