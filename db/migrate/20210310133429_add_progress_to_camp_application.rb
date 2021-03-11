class AddProgressToCampApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :camp_applications, :progress, :integer, default: 0
  end
end
