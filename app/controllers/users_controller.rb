class UsersController < ApplicationController
  before_action :check_logged_in, only: :profile
  def profile
    @user = current_user
  end

  private
  def check_logged_in
    if current_user.nil?
      redirect_to user_session_path
    end
  end
end