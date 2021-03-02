class UsersController < ApplicationController
  before_action :check_logged_in, only: :profile
  before_action :is_admin?, except: [:profile]
  def profile
    @user = current_user
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password].present?
      if @user.update(user_params)
        redirect_to @user, notice: "User updated successfully"
      else
        render 'edit'
      end
    else
      if @user.update(params.require(:user).permit(:first_name, :middle_name, :last_name, :phone_number,
                                                   :country, :email, :avatar))
        redirect_to @user, notice: "User updated successfully"
      else
        render 'edit'
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to users_path, notice: 'User has been deleted.'
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :phone_number, :country, :email, :avatar,
                                 :password, :password_confirmation)
  end

  def check_logged_in
    redirect_to user_session_path if current_user.nil?
  end
end
