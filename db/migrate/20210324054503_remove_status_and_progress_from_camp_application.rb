class RemoveStatusAndProgressFromCampApplication < ActiveRecord::Migration[5.2]
  def change
  	remove_column :camp_applications, :status
  	remove_column :camp_applications, :progress
  end
end
