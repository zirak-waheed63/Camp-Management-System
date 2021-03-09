class CreateCampApplication < ActiveRecord::Migration[5.2]
  def change
    create_table :camp_applications do |t|
      t.belongs_to :user
      t.belongs_to :camp
      t.string :name
      t.string :email
      t.string :gender
      t.string :step_two
      t.string :step_three
      t.string :step_four
      t.string :step_five
      t.string :step_six
      t.string :step_seven
      t.string :step_eight
      t.string :step_nine
      t.string :step_ten
    end
  end
end
