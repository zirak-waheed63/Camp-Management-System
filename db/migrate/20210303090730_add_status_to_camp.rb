class AddStatusToCamp < ActiveRecord::Migration[5.2]
  def change
    add_column :camps, :status, :boolean, default: false
  end
end
