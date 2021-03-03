class CreateJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :camps, :camp_locations do |t|
       t.index [:camp_id, :camp_location_id]
       t.index [:camp_location_id, :camp_id]
    end
  end
end
