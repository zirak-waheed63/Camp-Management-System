class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :check_logged_in, only: :profile
  before_action :is_admin?, only: %i[index show edit update destroy]
  def profile
    @user = current_user
  end

  def index
    @users = if params[:search].present?
               @search = params[:search]
               User.search(params[:search]).order("#{sort_column} #{sort_direction}").page params[:page]
             else
               @search = ''
               User.order("#{sort_column} #{sort_direction}").page params[:page]
             end
    respond_to do |format|
      format.html
      format.csv { send_data User.all.to_csv, filename: "users-#{Date.today}.csv" }
    end
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
        redirect_to @user, notice: 'User updated successfully'
      else
        render 'edit'
      end
    else
      if @user.update(params.require(:user).permit(:first_name, :middle_name, :last_name, :phone_number,
                                                   :country, :email, :avatar))
        redirect_to @user, notice: 'User updated successfully'
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
    redirect_to user_session_path if current_user.blank?
  end

  def sortable_columns
    ['first_name', 'phone_number', 'country', 'email']
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : 'first_name'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
