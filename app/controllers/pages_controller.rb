class PagesController < ApplicationController
  before_action :is_user?
  def home
    @camps = Camp.all.where(status: true)
  end
end