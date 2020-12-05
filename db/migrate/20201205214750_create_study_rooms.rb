class CreateStudyRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :study_rooms do |t|
      t.integer :rank
      t.integer :number_student

      t.timestamps
    end
  end
end
