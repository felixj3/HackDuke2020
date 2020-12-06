class CreateTutors < ActiveRecord::Migration[6.0]
  def change
    create_table :tutors do |t|
      t.string :subject
      t.string :number
      t.string :grade
      t.string :availability
      t.string :pay

      t.belongs_to :user

      t.timestamps
    end
  end
end
