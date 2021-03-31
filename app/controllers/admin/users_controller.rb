class Admin::UsersController < Admin::BaseController
  before_action :set_user, except: :index

  def index
    @users = User.search(params[:search], params[:column], params[:direction], params[:page])
    respond_to do |format|
      format.html
      format.csv { send_data User.all.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'User updated successfully'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy!
    redirect_to  admin_users_path, notice: 'User has been deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :middle_name, :last_name, :phone_number, :country, :email, :avatar)
  end

  
end
