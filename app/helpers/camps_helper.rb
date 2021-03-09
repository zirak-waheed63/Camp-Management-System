module CampsHelper
  def is_started?(camp)
    camp.camp_applications.where(user_id: current_user.id).present?
  end
end
