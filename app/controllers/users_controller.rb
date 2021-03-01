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
  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to users_path, :notice => 'User has been deleted.'
  end
  private
  def check_logged_in
    if current_user.nil?
      redirect_to user_session_path
    end
  end
end