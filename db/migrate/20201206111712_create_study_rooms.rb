class CreateStudyRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :study_rooms do |t|
      t.integer :rank
      t.integer :capacity
      t.integer :current_number_student
      t.string :major
      t.string :description

      t.timestamps
    end
  end
end
