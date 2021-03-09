class AddStatusToCampApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :camp_applications, :status, :string, default: 'personal_information'
  end
end
