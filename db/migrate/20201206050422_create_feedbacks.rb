class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.float :courseDis 
      t.float :homeDis
      t.float :majorDis
      t.float :gradDis
      t.float :involvDot

      t.timestamps
    end
  end
end
