class AddStepsJsonToCampApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :camp_applications, :steps, :json, default: {}
  end
end
